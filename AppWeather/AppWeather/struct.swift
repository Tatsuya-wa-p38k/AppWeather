
import Foundation

import YumemiWeather

// WeatherDate 構造体を定義します。
//これは Codable プロトコルに準拠しており、JSONとの相互変換が可能です。
struct WeatherDate: Codable {
    let area: String // area は地域を表す文字列です。
    let date: String // date は日付を表す文字列です。
}

// Weather 構造体を定義します。
//これは Codable プロトコルに準拠しており、JSONとの相互変換が可能です。
struct Weather: Codable {
    let maxTemperature: Int// 最高気温を表す整数値です。
    let minTemperature: Int// 最低気温を表す整数値です。
    let setWeatherType: String// 天気の種類を表す文字列です。

        // CodingKeys 列挙型を定義します。これはJSONのキー名とSwiftのプロパティ名をマッピングします。
        enum CodingKeys: String, CodingKey {
        // JSON中の "max_temperature" キーを maxTemperature プロパティにマッピングします。
        case maxTemperature = "max_temperature"
        // JSON中の "min_temperature" キーを minTemperature プロパティにマッピングします。
        case minTemperature = "min_temperature"
        // JSON中の "weather_condition" キーを setWeatherType プロパティにマッピングします。
        case setWeatherType = "weather_condition"
    }
}

// WeatherRequest 構造体を定義、APIにリクエストを送る際のJSONデータ構造を表します。
struct WeatherRequest: Codable {
    // 地域名の配列です。複数の地域の天気を一度に要求できることを示しています。
    let areas: [String]

    // 天気予報を要求する日付を表す文字列です。
    let date: String
}

// AreaWeather 構造体を定義します。これはAPIからのレスポンスデータ構造を表します。
struct AreaWeather: Codable {
    // area プロパティは Area 型です。Area 型の定義がコード内に見当たらないため、
    // おそらく別の場所で定義されていると思われます。これは地域情報を表すと推測されます。
    let area: Area

    // info プロパティは Weather 型で、その地域の天気情報を保持します。
    let info: Weather
}
