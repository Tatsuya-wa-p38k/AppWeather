

import Foundation
import YumemiWeather

struct WeatherDate:Codable {
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

//WeatherList.swift用のstructを記載する

//API に請求する JSON 文字列の例：
struct WeatherRequest: Codable {
    let areas: [String]
    let date: String
}

//返された AreaResponse の JSON 文字列の例
struct AreaWeather: Codable {
    let area: Area
    let info: Weather
}

