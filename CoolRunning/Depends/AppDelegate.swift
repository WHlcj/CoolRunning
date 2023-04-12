import Foundation
import UIKit

import OHMySQL
import QWeather

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //add code when didFinishLaunchingWithOptions
        
        // 和风天气配置文件
        let QWeatherConfigInstance = AllWeatherInquieirs.sharedInstance()
        QWeatherConfigInstance?.publicID = "HE2303221511341900"
        QWeatherConfigInstance?.appKey = "56edd9f6407743c2a9949b870ae66c42"
        // 配置项目订阅版本（免费版）
        QWeatherConfigInstance?.appType = .DEV
    
        return true
    }
}
