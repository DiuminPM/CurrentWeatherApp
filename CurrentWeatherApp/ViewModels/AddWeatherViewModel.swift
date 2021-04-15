//
//  AddWeatherViewModel.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation
class AddWeatherViewModel: ObservableObject {
    var city: String = ""
    
    func save(completion: @escaping (WeatherViewModel) -> Void) {
        CurrenWeatherAPIManager().getWeatherByCity(city: city) { (result) in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    completion(WeatherViewModel(weather: weather))
                }
            case .failure(let error):
                print(error, "опачки")
            }
            
        }
        
    }
    
    func saveByCoordinates(coordinates: Coordinates,completion: @escaping (WeatherViewModel) -> Void) {
        CurrenWeatherAPIManager().getWeatherByCoordinates(coordinates: coordinates) { (result) in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    completion(WeatherViewModel(weather: weather))
                }
            case .failure(let error):
                print(error, "опачки")
            }
        }
        
    }
    
//    func switchUnits(temperature: Double, toggleValue: Bool) -> Double {
//        let selectedUnit: Double?
//        if toggleValue == true { selectedUnit = temperature - 273}
//        else {selectedUnit = temperature}
//        return selectedUnit!
//
//    }
    func switchUnits(temperature: Double, toggleValue: Bool) -> String {
        let selectedUnit: String?
        if toggleValue == true { selectedUnit = "\(Int(temperature) - 273)˚ C"}
        else {selectedUnit = "\(Int(temperature))˚ F"}
        return selectedUnit!
            
    }
    func colorCurrentContent(temperature: Double, toggleValue: Bool) -> String {
        switch temperature {
        case ..<283:
                return "Light blue"
        case 283..<298:
                return "orange"
        case 298...:
                return "red"
        default:
            return "white"
        }
    }
}
