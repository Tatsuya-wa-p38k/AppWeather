
import Foundation
import YumemiWeather

class WeatherDetail {
    //サブスレッドの中にメインスレッドが入っているので二つを分ける
    func setWeatherType(completion: @escaping (Result<Weather, Error>) -> Void) {
        DispatchQueue.global().async {
            let sendJsonString = WeatherDate(area: "Tokyo",
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
                
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Weather.self, from: jsonData)
                
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

