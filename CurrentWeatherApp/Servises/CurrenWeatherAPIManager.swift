//
//  CurrenWeatherAPIManager.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
}

class CurrenWeatherAPIManager {
    
    func getWeatherByCity(city: String, completion: @escaping ((Result<Weather, NetworkError>) -> Void)) {
        
        guard let weatherURL = Constants.UrlAPI.weatherByCity(city: city) else {
            return completion(.failure(.badURL))
        }
        
        URLSession.shared.dataTask(with: weatherURL) { (data, _, error) in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            let weatherResponse = try? JSONDecoder().decode(CurrentWeather.self, from: data)
            
            if let weatherResponse = weatherResponse {
                completion(.success(weatherResponse.weather))
                print(weatherResponse)
            }
            
        }.resume()
    }
    
}
