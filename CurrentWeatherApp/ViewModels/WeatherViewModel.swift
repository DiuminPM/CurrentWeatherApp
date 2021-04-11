//
//  WeatherViewModel.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation
struct WeatherViewModel {
    let weather: Weather
    let id = UUID()
    var temperature: Double {
        return weather.temperature
    }
    var city: String {
        return weather.city
    }
}
