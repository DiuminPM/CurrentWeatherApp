//
//  UrlAPI.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation
struct Constants {
    struct UrlAPI {
        static func weatherByCity(city: String) -> URL? {
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=1d8b02cdb8fd65b89b50f2d52959d35a")
        }
        
        static func weatherUrlAsStringByIcon(icon: String) -> String {
            return "https://openweathermap.org/img/w/\(icon).png"
        }
    }
}

