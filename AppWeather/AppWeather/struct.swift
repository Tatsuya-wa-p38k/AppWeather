//
//  struct.swift
//  AppWeather
//
//  Created by spark-06 on 2024/05/29.
//

import Foundation

struct Date:Codable {
    let area:String
    let date:String
}

struct Weather:Codable {
    let maxTemperature: Int
    let minTemperature: Int
    let setWeatherType: String

    enum CodingKeys: String, CodingKey {
        case maxTemperature = "max_temperature"
        case minTemperature = "min_temperature"
        case setWeatherType = "weather_condition"
    }
}
