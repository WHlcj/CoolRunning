
import SwiftUI

@main
struct AppEntry: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            OpeningScreen()
            //WeatherInfoView()
        }
    }
}
