
import SwiftUI
import AGConnectCore

@main
struct AppEntry: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            draft1()
//            OpeningScreen()
        }
    }
}
