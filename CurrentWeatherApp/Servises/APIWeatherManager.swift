//
//  APIWeatherManager.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation

struct Coordinates {
  let latitude: Double
  let longitude: Double
}


  
//    api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
let url = URL(string: "api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}")



final class APIWeatherManager: APIManager {
  let url = URL(string: "api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}")
  var sessionConfiguration: URLSessionConfiguration

  lazy var session: URLSession = {
    return URLSession(configuration: self.sessionConfiguration)
  } ()
  
  let apiKey: String
  
  init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
    self.sessionConfiguration = sessionConfiguration
    self.apiKey = apiKey
  }
  
  convenience init(apiKey: String) {
    self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
  }
  
  func fetchCurrentWeatherWith(coordinates: Coordinates, completionHandler: @escaping (APIResult<CurrentWeather>) -> Void) {
    let request = ForecastType.Current(apiKey: self.apiKey, coordinates: coordinates).request
    
    fetch(request: request, parse: { (json) -> CurrentWeather? in
      if let dictionary = json["main"] as? [String: AnyObject] {
        return CurrentWeather(JSON: dictionary)
      } else {
        return nil
      }
      
      }, completionHandler: completionHandler)
  }
}
