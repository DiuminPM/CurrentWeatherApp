//
//  UserDefaultsStore.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 11.04.2021.
//

import Foundation
class UserDefaultsStore: ObservableObject {
    @Published var weatherList = [WeatherViewModel]()
    @Published var currentCity: String = "Stuttgard"
    func addWeather(_ weather: WeatherViewModel) {
        weatherList.append(weather)
        print(currentCity)
    }
}
