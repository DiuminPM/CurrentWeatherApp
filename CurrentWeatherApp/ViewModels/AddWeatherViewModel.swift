//
//  AddWeatherViewModel.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation
class AddWeatherViewModel: ObservableObject {
    var city: String = "Paris"
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
    func switchUnits(temperature: Double, toggleValue: Bool) -> Double {
        let selectedUnit: Double?
        if toggleValue == true { selectedUnit = temperature - 273}
        else {selectedUnit = temperature}
        return selectedUnit!
            
    }
    func colorCurrentContent(temperature: Double, toggleValue: Bool) -> String {
        switch toggleValue {
        case true:
            switch temperature {
            case ...9:
                    return "Light blue"
            case 10...24:
                    return "orange"
            case 25...:
                    return "red"
            default:
                return "white"
            }
        case false:
            switch temperature {
            case ...282:
                    return "Light blue"
            case 283...297:
                    return "orange"
            case 298...:
                    return "red"
            default:
                return "white"
            }
        }
    }
}
