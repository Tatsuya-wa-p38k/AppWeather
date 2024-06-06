
import Foundation
import YumemiWeather

class WeatherList {
    
    //ResultでString型ではなく、structのAreaWeatherで返す
    func fetchWeatherList(completion: @escaping (Result<[AreaWeather], Error>) -> Void) {
        DispatchQueue.global().async {
            // 現在時刻をISO8601形式の文字列に変換
            let dateFormatter = ISO8601DateFormatter()
            let formattedDate = dateFormatter.string(from: Date())
            //areas:[]を空にすることで全部の地域が表示される
            let sendJsonString = WeatherRequest(areas:[],
                                                date: formattedDate) //更新処理がかかった瞬間の時間
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
