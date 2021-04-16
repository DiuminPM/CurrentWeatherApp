//
//  ContentView.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 09.04.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var addWeatherVM = AddWeatherViewModel()
    @State var toggleValue: Bool = false
    @State var currentCity: String = "Stutgard"
    @State var currentTemperature: Double = 0
    @State var isPresenter: Bool = false
    @State var countWeatherList: Int = 0
    @State var isHide: Bool = true
    @StateObject var searchViewModel = SearchViewModel()
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    var body: some View {
            NavigationView {
                VStack {
                    SeachView(toggleValue: $toggleValue, currentCity: $currentCity, currentTemperature: $currentTemperature, isPresenter: $isPresenter, countWeatherList: $countWeatherList, isHide: $isHide)
                }
                .sheet(isPresented: $isPresenter, content: {DetailWeatherCityView(toggleUnitsTemp: $toggleValue, isPresenter: $isPresenter, countWeatherList: $countWeatherList, isHide: $isHide)} )
                .multilineTextAlignment(.leading)
                .navigationBarTitle(Text("Weather"), displayMode: .inline)
                .onAppear(perform: {
                    UINavigationBar.appearance().standardAppearance.shadowColor = .clear
                })
                .toolbar {
                       ToolbarItem(placement: .navigationBarTrailing) {
                        ToolBarButton(currentCity: $currentCity, temperature: $currentTemperature)
                       }
                }
            }
            .onAppear{
                // MARK: - fetch CoreData
                let context = searchViewModel.getContext()
                let fetchRequest: NSFetchRequest<WeatherCore> = WeatherCore.fetchRequest()
                let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
                fetchRequest.sortDescriptors = [sortDescriptor]
                do {
                    SearchViewModel.weathersCore = try context.fetch(fetchRequest)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
                // MARK: - fetch cityList
                searchViewModel.makedCityList()
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SearchViewModel())
    }
}
