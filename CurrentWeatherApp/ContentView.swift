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
    @State var currentCity: String = "Petrozavodsk"
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
                if countWeatherList > 1 {
                    isHide = false
                }
                print("тута\(countWeatherList)")

                let context = getContext()
                let fetchRequest: NSFetchRequest<WeatherCore> = WeatherCore.fetchRequest()
                let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
                fetchRequest.sortDescriptors = [sortDescriptor]
                do {
                    SearchViewModel.weathersCore = try context.fetch(fetchRequest)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
                // MARK: - start city current weather
                addWeatherVM.city = currentCity
                addWeatherVM.save { (weather) in
                    self.currentTemperature = weather.temperature
                    self.currentCity = weather.city
                    searchViewModel.saveWeatherCore(with: weather.city, with: weather.temperature, with: CurrentData.dateFormatter())
                    
                }
                
                // MARK: - Clear CoreData
//                if let objects = try? context.fetch(fetchRequest) {
//                            for object in objects {
//                                context.delete(object)
//                            }
//                        }
//
//                        do {
//                            try context.save()
//                        } catch let error as NSError {
//                            print(error.localizedDescription)
//                        }
                print("проверка\(SearchViewModel.weathersCore)")
                
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SearchViewModel())
    }
}
