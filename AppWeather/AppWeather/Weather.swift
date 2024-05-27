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
    //エラー発生時の処理をプロトコル記載する
    func didEncounterError(error: Error)
}

class WeatherDetail {
    
    var delegate:WeatherDelegate?

    let requestJson = """
{
    "area": "Tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}
"""

    func setWeatherType() {
        //エラー発生時の処理をdelegateを用いて記載する
        do {
            let fetchWeatherString = try YumemiWeather.fetchWeather(requestJson)
            print(fetchWeatherString)

            self.delegate?.setWeatherType(type: fetchWeatherString)
        } catch {
            print(error)
            self.delegate?.didEncounterError(error: error)
        }
    }
}
