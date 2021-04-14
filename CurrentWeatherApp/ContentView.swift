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
    @State var currentCity: String = "Stuttgard"
    @State var currentTemperature: Double = 0
    @State var isPresenter: Bool = false
    @StateObject var searchViewModel = SearchViewModel()
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    var body: some View {
            NavigationView {
                
                VStack {
                    SeachView(toggleValue: $toggleValue, currentCity: $currentCity, currentTemperature: $currentTemperature, isPresenter: $isPresenter)
                    
                    
                }
                .sheet(isPresented: $isPresenter, content: {DetailWeatherCityView(toggleValue: $toggleValue, currentCity: $currentCity, currentTemperature: $currentTemperature, isPresenter: $isPresenter)} )
                .multilineTextAlignment(.leading)
                .navigationBarTitle(Text("Weather"), displayMode: .inline)
                .onAppear(perform: {
                    UINavigationBar.appearance().standardAppearance.shadowColor = .clear
//                    newAppearance.configureWithOpaqueBackground()
//                    newAppearance.backgroundColor = .white
                })
                .toolbar {
                       ToolbarItem(placement: .navigationBarTrailing) {
                        ToolBarButton(city: $currentCity, temperature: $currentTemperature)
                       }
               }
            }
            
            .onAppear{
                //        let context = getContext()
                //        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
                //        if let objects = try? context.fetch(fetchRequest) {
                //            for object in objects {
                //                context.delete(object)
                //            }
                //        }
                //
                //        do {
                //            try context.save()
                //        } catch let error as NSError {
                //            print(error.localizedDescription)
                //        }
                
                let context = getContext()
                let fetchRequest: NSFetchRequest<WeatherCore> = WeatherCore.fetchRequest()
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
                do {
                    SearchViewModel.weathersCore = try context.fetch(fetchRequest)
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
                
                print("проверка\(SearchViewModel.weathersCore)")
                
            }
        }
        
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SearchViewModel())
    }
}
