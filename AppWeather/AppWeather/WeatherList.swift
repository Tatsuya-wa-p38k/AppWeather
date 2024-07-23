
import Foundation
import YumemiWeather

// WeatherListクラスを定義、天気情報のリストを取得する機能を持つ
class WeatherList {
    
    // fetchWeatherList関数を定義、非同期で天気情報のリストを取得
    // 結果は[AreaWeather]型（成功の場合）またはError型（失敗の場合）で返す
    func fetchWeatherList(completion: @escaping (Result<[AreaWeather], Error>) -> Void) {
        // バックグラウンドスレッドで処理を実行します。これによりメインスレッドがブロックされません。
        DispatchQueue.global().async {
            // 現在時刻をISO8601形式の文字列に変換
            let dateFormatter = ISO8601DateFormatter()
            let formattedDate = dateFormatter.string(from: Date())
            // WeatherRequestオブジェクトを作成、areas: []は空の配列で、全ての地域の天気を取得することを意味する
            let sendJsonString = WeatherRequest(areas:[],
                                                date: formattedDate) //更新処理がかかった瞬間の時間
            do {
                // JSONEncoderを使用してWeatherRequestオブジェクトをJSONデータに変換
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(sendJsonString)

                // JSONデータをUTF-8エンコードの文字列に変換
                guard let sendJsonString = String(data:jsonData, encoding: .utf8) else {
                    return
                }

                // YumemiWeather.syncFetchWeatherList関数を使用して天気情報を取得
                let fetchWeatherListString = try YumemiWeather.syncFetchWeatherList(sendJsonString)

                // 取得した天気情報の文字列をJSONデータに変換
                guard let jsonData = fetchWeatherListString.data(using: .utf8) else {
                    return
                }

                // JSONデコーダーを使用してJSONデータを[AreaWeather]型の配列に変換
                let decoder = JSONDecoder()
                let weatherList = try decoder.decode([AreaWeather].self, from: jsonData)

                // デバッグ用に天気情報リストを出力
                print(weatherList)

                // 成功した場合、completion handlerに結果を渡す
                completion(.success(weatherList))
            }
            catch {
                // エラーが発生した場合、completion handlerにエラーを渡す
                completion(.failure(error))
            }
        }
    }
}
