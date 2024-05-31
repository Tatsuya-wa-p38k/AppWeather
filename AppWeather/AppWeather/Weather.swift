
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

class WeatherDetail {
    //サブスレッドの中にメインスレッドが入っているので二つを分ける
    func setWeatherType(completion: @escaping (Result<Weather, Error>) -> Void) {
        DispatchQueue.global().async {
            let sendJsonString = Date(area: "Tokyo",
                                      date: "2020-04-01T12:00:00+09:00")
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(sendJsonString)
                guard let sendJsonString = String(data:jsonData, encoding: .utf8) else {
                    return
                }

                let fetchWeatherString = try YumemiWeather.syncFetchWeather(sendJsonString)

                guard let jsonData = fetchWeatherString.data(using: .utf8) else {
                    return
                }

                let weather = try JSONDecoder().decode(Weather.self, from: jsonData)
                    completion(.success(weather))
            } catch {
                    completion(.failure(error))

            }
        }
    }
}

