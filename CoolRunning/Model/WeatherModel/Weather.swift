
import Foundation
/// 和风天气回传JSON解码信息
struct WeatherData: Codable {
    let now: Now
}
/// 天气JSON解码信息
struct Now: Codable {
    let temp: String
    // 体感温度
    let feelsLike: String
    let icon: String
    // 天气状况的文字描述
    let text: String
}
/// 天气Model
///
/// 使用的天气信息模组
/// ```
/// let weather = Weather(icon: "001", temp: "15.5", text: "晴")
/// ```
///
struct Weather {
    let icon: String
    let temp: String
    let text: String
    
    var tempString: String {
        temp + "℃"
    }
    
    var iconName: String {
        switch icon {
        case "151":
            return "153"
        default:
            return icon
        }
    }
}
