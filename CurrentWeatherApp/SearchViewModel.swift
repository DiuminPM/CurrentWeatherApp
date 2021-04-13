//
//  SearchViewModel.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 11.04.2021.
//

import Foundation
import CoreData
import UIKit

protocol SearchViewModelProtocol {
    static var weathersCore: [WeatherCore] { get }
    static var weathers: [WeatherViewModel] { get }

    var currentCity: String {get}
    var currentTemperature: Double {get}
    func fetchWeathers()
}

class SearchViewModel: NSObject, SearchViewModelProtocol, ObservableObject {
    
    @Published var currentTemperature: Double = 0.0
    var currentCity: String = ""
    static var weathers: [WeatherViewModel] = []
    static var weathersCore: [WeatherCore] = []
    
//    override init() {
//        super.init()
//        let context = getContext()
//        let fetchRequest: NSFetchRequest<WeatherCore> = WeatherCore.fetchRequest()
//        do {
//            SearchViewModel.weathersCore = try context.fetch(fetchRequest)
//
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//        print("проверка\(SearchViewModel.weathersCore)")
//    }
    
    func fetchWeathers() {
        
        print(currentCity)
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func addWeather(_ weather: WeatherViewModel) {
        SearchViewModel.weathers.append(weather)
        print("проверка\(SearchViewModel.weathers)")
    }
    func saveWeatherCore (with city: String, with temperature: Double) {
        
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherCore", in: context) else { return }
        
        let weatherObject = WeatherCore(entity: entity, insertInto: context)
        weatherObject.city = city
        weatherObject.temperature = temperature
        weatherObject.id = UUID()
        
        do {
            try context.save()
            SearchViewModel.weathersCore.append(weatherObject)
            print(SearchViewModel.weathersCore)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
//addWeatherVM.save { (weather) in
//    store.addWeather(weather)
//    self.currentCity = weather.city
