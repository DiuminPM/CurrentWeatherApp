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
    static var cityWeathers: [WeatherCore] = []
    static var temperaturesForCharts: [Double] = []
    static var cityList: [String] = []
    static var unicalyWeatherList: [CityList] = []
    
    typealias CityList = (city: String, id: UUID, weatherCore: [WeatherCore])
    
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
    func saveWeatherCore (with city: String?, with temperature: Double?, with date: String?) {
        
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "WeatherCore", in: context) else { return }
        
        let weatherObject = WeatherCore(entity: entity, insertInto: context)
        weatherObject.city = city
        weatherObject.temperature = temperature!
        weatherObject.id = UUID()
        weatherObject.date = date
        
        do {
            try context.save()
            SearchViewModel.weathersCore.insert(weatherObject, at: 0)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func addCityWheater (currentCity: String) {
        var cityList: [WeatherCore] = []
        cityList = SearchViewModel.weathersCore.filter({ (weather) -> Bool in
            if  weather.city == currentCity {
                return true
            }
            return false
        })
        SearchViewModel.cityWeathers = cityList.sorted(by: { (s1, s2) -> Bool in
            if s1.date! < s2.date! {
                return false
            }
            return true
        })
    }
    
    func addTemperaturesForChart() {
        for weather in SearchViewModel.cityWeathers {
            SearchViewModel.temperaturesForCharts.append(weather.temperature)
        }
    }
    func distinct<T: Equatable>(source: [T]) -> [T] {
      var unique = [T]()
      for item in source {
        if !unique.contains(item) {
          unique.append(item)
        }
      }
      return unique
    }
    
    func makedCityList() {
        for weatherList in SearchViewModel.weathersCore {
            SearchViewModel.cityList.append(weatherList.city!)
        }
        let uniqueCity = distinct(source: SearchViewModel.cityList)
        let uniqueCityList = uniqueCity.map{ (list) -> CityList in
            return (list, UUID(), SearchViewModel.weathersCore.filter({ (word) -> Bool in
                String((word.city)!) == list
            }))
        }
        SearchViewModel.unicalyWeatherList = uniqueCityList
        print(uniqueCityList.count)
        
    }
    
    
}
