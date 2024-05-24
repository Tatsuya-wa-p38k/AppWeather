//
//  Weather.swift
//  AppWeather
//
//  Created by spark-06 on 2024/05/24.
//

import Foundation
import YumemiWeather

protocol WeatherDelegate {
    func setWeatherType(type: String)
}

class WeatherDetail {
    
    var delegate:WeatherDelegate?

    func setWeatherType() {
        let fetchWeatherString = YumemiWeather.fetchWeatherCondition()
        delegate?.setWeatherType(type: fetchWeatherString)
    }
}
