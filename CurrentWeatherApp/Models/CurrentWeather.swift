//
//  CurrentWeather.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation


struct CurrentWeather: Decodable {
    let name: String
    var weather: Weather
    
    private enum CodingKeys: String,CodingKey {
        case name
        case weather = "main"
    }
    
    enum WeatherKeys: String, CodingKey {
        case temperatue = "temp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        
        let weatherContainer = try container.nestedContainer(keyedBy: WeatherKeys.self, forKey: .weather)
        let temperature = try weatherContainer.decode(Double.self, forKey: .temperatue)
        weather = Weather(city: name, temperature: temperature)
    }
}

struct Weather: Decodable {
    let city: String
    let temperature: Double
}
