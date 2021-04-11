//
//  FetchCurrentweather.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation

class FetchCurrentweather: NSObject, ObservableObject {
    var currentTemperature: Double = 0
    var locationViewModel = LocationViewModel()
    lazy var weatherManager = APIWeatherManager(apiKey: "1d8b02cdb8fd65b89b50f2d52959d35a")
    
    override init() {
      super.init()
      
    }
    func fetchCurrentWeatherData(){
        let coordinates = Coordinates(latitude: locationViewModel.userLatitude, longitude: locationViewModel.userLongitude)
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            switch result {
            case .Success(let currentWeather):
                self.updateUIWith(currentWeather: currentWeather)
            case .Failure(let error as NSError):
            print(error)
            default: break
            }
        }
    }
    
//    func fetchCurrentWeatherDataCity() {
//        weatherManager.fetchCurrentWeatherCityWith(city: "Petrozavodsk") { (result) in
//            switch result {
//            case .Success(let currentWeather):
//                self.updateUIWith(currentWeather: currentWeather)
//            case .Failure(let error as NSError):
//            print(error)
//            default: break
//            }
//        }
//    }
    func updateUIWith(currentWeather: CurrentWeather) {
      
        self.currentTemperature = currentWeather.temp
      
    }
}
