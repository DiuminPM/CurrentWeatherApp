//
//  CurrentWeather.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation
import UIKit

struct CurrentWeather {
  let temperature: Double
  let city: String
}

extension CurrentWeather: JSONDecodable {
  init?(JSON: [String : AnyObject]) {
    guard let temperature = JSON["temperature"] as? Double,
    let city = JSON["city"] as? String else {
        return nil
    }

    self.temperature = temperature
    self.city = city
  }
}


extension CurrentWeather {
    
  var temperatureString: String {
    return "\(Int(5 / 9 * (temperature - 32)))˚C"
  }
  
}
