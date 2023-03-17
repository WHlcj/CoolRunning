import Foundation
import UIKit

import AGConnectCore
import AGConnectCredential
import HMFoundation
import AGConnectAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //add code when didFinishLaunchingWithOptions
        // 创建AGCServicesConfig对象
        let config = AGCServicesConfig(defaultPlist: ())
        config.clientId = "1107923665854418752"
        config.clientSecret = "B8BA3E02E910C8BFA30D1F0B7C89CC139710098688124BB6F9DC4559F6A4BD02"
        config.apiKey = "DAEDAJDlV9nNsiMtq49IJjAF8EtwivX8cTYFBvduOKrP0cKKrs+wdz9CYWXXMrXFCJoEfyHeXBgg+QEI9Ip4/2fG5wBencAMUwuEHw=="
        // 初始化AGC SDK
        AGCInstance.startUp(config)
        // 配置SDK联网能力
        AGCInstance.setAccessNetworkStatus(true)
        
        return true
    }
}
