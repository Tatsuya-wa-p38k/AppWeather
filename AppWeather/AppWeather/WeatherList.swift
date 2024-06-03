
import Foundation
import YumemiWeather

class WeatherList {

    //ResultでString型ではなく、structのAreaWeatherで返す
    func fetchWeatherList(completion: @escaping (Result<[AreaWeather], Error>) -> Void) {

        let sendJsonString = WeatherRequest(areas:["Area"],
                                            date: "2020-04-01T12:00:00+09:00")

        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(sendJsonString)
            guard let sendJsonString = String(data:jsonData, encoding: .utf8) else {
                return
            }

            let fetchWeatherListString = try YumemiWeather.syncFetchWeatherList(sendJsonString)

            guard let jsonData = fetchWeatherListString.data(using: .utf8) else {
                return
            }

            let decoder = JSONDecoder()
            let weatherList = try decoder.decode([AreaWeather].self, from: jsonData)

            // 各地の天気情報を出力する
            for areaWeather in weatherList {
                print("最高気温: \(areaWeather.info.maxTemperature) ℃")
                print("最低気温: \(areaWeather.info.minTemperature) ℃")
                print("天気: \(areaWeather.info.setWeatherType)")
            }
        } catch {
            print("エラーが発生しました: \(error)")
        }
    }
}
