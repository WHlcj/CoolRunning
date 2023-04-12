
import Foundation

struct WeatherData: Codable {
    let code: String
    let updateTime: String
    let fxLink: String
    let now: NowInfo
    let refer: ReferInfo
}

struct NowInfo: Codable {
    // 数据观测时间
    let obsTime: String
    let temp: String
    // 体感温度
    let feelsLike: String
    let icon: String
    // 天气状况的文字描述
    let text: String
    // 风向360角度
    let wind360: String
    // 风向
    let windDir: String
    // 风力等级
    let windScale: String
    // 风速,km/h
    let windSpeed: String
    // 相对湿度,%
    let humidity: String
    // 当前小时累计降水量,mm
    let precip: String
    // 大气压强,百帕
    let pressure: String
    // 能见度,km
    let vis: String
    // 云量,%
    let cloud: String?
    // 露点温度
    let dew: String?
}

struct ReferInfo: Codable {
    // 原始数据来源或数据源说明
    let sources: [String]?
    // 数据许可或版权声明
    let license: [String]?
}
