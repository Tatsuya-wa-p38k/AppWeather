
import Foundation
import YumemiWeather

class WeatherList {

    //ResultでString型ではなく、structのAreaWeatherで返す
    func fetchWeatherList(completion: @escaping (Result<[AreaWeather], Error>) -> Void) {
        DispatchQueue.global().async {
            //areas:[]を空にすることで全部の地域が表示される
            let sendJsonString = WeatherRequest(areas:[],
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

            print(weatherList)
                completion(.success(weatherList))
                }
             catch {
                completion(.failure(error))
            }
        }
    }
}
