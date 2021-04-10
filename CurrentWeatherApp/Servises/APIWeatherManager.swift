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

enum ForecastType: FinalURLPoint {
  case CurrentCity(apiKey: String, city: String)
  case CurrentCoordinates(apiKey: String, coordinates: Coordinates)

  
  var baseURL: URL {
    return URL(string: "api.openweathermap.org/data/2.5")!
  }
  
  var path: String {
    switch self {
    case .CurrentCity(let apiKey, let city):
        return "/weather?q=\(city)&appid=\(apiKey)"
//      return "/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)"
    case .CurrentCoordinates(let apiKey, let coordinates):
        return "/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(apiKey)"
    }
  }
  
  var request: URLRequest {
    let url = URL(string: path, relativeTo: baseURL)
    return URLRequest(url: url!)
  }
}



final class APIWeatherManager: APIManager {
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
  
  func fetchCurrentWeatherCoordinatesWith(coordinates: Coordinates, completionHandler: @escaping (APIResult<CurrentWeather>) -> Void) {
    let request = ForecastType.CurrentCoordinates(apiKey: self.apiKey, coordinates: coordinates).request
    
    fetch(request: request, parse: { (json) -> CurrentWeather? in
      if let dictionary = json["currently"] as? [String: AnyObject] {
        return CurrentWeather(JSON: dictionary)
      } else {
        return nil
      }
      
      }, completionHandler: completionHandler)
  }
    
    func fetchCurrentWeatherCityWith(city: String, completionHandler: @escaping (APIResult<CurrentWeather>) -> Void) {
    let request = ForecastType.CurrentCity(apiKey: self.apiKey, city: city).request
    
    fetch(request: request, parse: { (json) -> CurrentWeather? in
      if let dictionary = json["currently"] as? [String: AnyObject] {
        return CurrentWeather(JSON: dictionary)
      } else {
        return nil
      }
      
      }, completionHandler: completionHandler)
  }
}
