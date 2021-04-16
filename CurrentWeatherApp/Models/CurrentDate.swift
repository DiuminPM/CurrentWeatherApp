//
//  CurrentDate.swift
//  CurrentWeatherApp
//
//  Created by DiuminPM on 10.04.2021.
//

import Foundation
struct CurrentData {
    static func dateFormatter() -> String {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM.dd.yyyy HH:mm:ss"
            let dateString = dateFormatter.string(from: date)
            return dateString
            //Custom date format Sample 1 =  02-28-2016 11:41
        }
}
