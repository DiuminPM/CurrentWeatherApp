//
//  SearchViewModel.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 11.04.2021.
//

import Foundation
protocol SearchViewModelProtocol {
    static var weathers: [WeatherViewModel] { get }
    var currentCity: String {get}
    var currentTemperature: Double {get}
    func fetchWeathers()
}

class SearchViewModel: SearchViewModelProtocol, ObservableObject {
    
    @Published var currentTemperature: Double = 0.0
    var currentCity: String = ""
    static var weathers: [WeatherViewModel] = []
    
    func fetchWeathers() {
        
        print(currentCity)
    }
    func addWeather(_ weather: WeatherViewModel) {
        SearchViewModel.weathers.append(weather)
        print(SearchViewModel.weathers)
    }
}
//addWeatherVM.save { (weather) in
//    store.addWeather(weather)
//    self.currentCity = weather.city