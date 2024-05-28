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

    func maxTemperature(max:Int)
    func minTemperature(min:Int)
}

class WeatherDetail {
    
    var delegate:WeatherDelegate?

    let sendJsonString = """
{
    "area": "Tokyo",
    "date": "2020-04-01T12:00:00+09:00"
}
"""

    func setWeatherType() {

        //エラー発生時の処理をdelegateを用いて記載する
        do {
            let fetchWeatherString = try YumemiWeather.fetchWeather(sendJsonString)

            // 1. UTF-8エンコーディングでDataオブジェクトに変換
            guard let jsonData = fetchWeatherString.data(using: .utf8),
                  // 2. JSONSerializationでJSONをSwiftデータに変換
                  let json = try JSONSerialization.jsonObject(with: jsonData, options:  []) as?
                    [String: Any],
                  let maxTemperature = json["max_temperature"] as? Int,
                  let minTemperature = json["min_temperature"] as? Int,
                  let weatherCondition = json["weather_condition"] as? String
            else {
                return
            }
            self.delegate?.setWeatherType(type: weatherCondition)
            self.delegate?.maxTemperature(max: maxTemperature)
            self.delegate?.minTemperature(min: minTemperature)


        } catch {
            print(error)
            self.delegate?.didEncounterError(error: error)
        }
    }
}
