//
//  Weather.swift
//  AppWeather
//
//  Created by spark-06 on 2024/05/24.
//

import Foundation
import YumemiWeather

//struct Date:Codable {
//    let area:String
//    let date:String
//}
//
//struct Weather:Codable {
//    let maxTemperature: Int
//    let minTemperature: Int
//    let setWeatherType: String
//
//    enum CodingKeys: String, CodingKey {
//        case maxTemperature = "max_temperature"
//        case minTemperature = "min_temperature"
//        case setWeatherType = "weather_condition"
//    }
//}

protocol WeatherDelegate {
    //エラー発生時の処理をプロトコル記載する
    func didEncounterError(error: Error)

    //新しい関数setWeatherを作り、structで３つのデータをまとめた
    func setWeather(weather: Weather)
}

class WeatherDetail {
    
    var delegate:WeatherDelegate?

    func setWeatherType() {
        let sendJsonString = Date(area: "Tokyo",
                                  date: "2020-04-01T12:00:00+09:00")
        //エラー発生時の処理をdelegateを用いて記載する
        do {
            let encoder = JSONEncoder()//エンコーダーの準備
            let jsonData = try encoder.encode(sendJsonString)
            guard let sendJsonString = String(data:jsonData, encoding: .utf8) else {
                return
            }

            let fetchWeatherString = try YumemiWeather.fetchWeather(sendJsonString)

            // 1. UTF-8エンコーディングでDataオブジェクトに変換
            guard let jsonData = fetchWeatherString.data(using: .utf8) else {
                return
            }
            // 2. JSONSerializationでJSONをSwiftデータに変換
            let json = try JSONSerialization.jsonObject(with: jsonData, options:  []) as?
            [String: Any]

            let weather = try JSONDecoder().decode(Weather.self, from: jsonData)
            //新しい関数setWeatherを作り、structで３つのデータをまとめた
            self.delegate?.setWeather(weather: weather)


        } catch {
            print(error)
            self.delegate?.didEncounterError(error: error)
        }
    }
}
