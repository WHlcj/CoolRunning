
import SwiftUI

struct HomeScreen: View {
    
    @AppStorage("signed_in") var currentUserSignedIn = false
    
    var body: some View {
        NavigationView {
            TabView {
                RunningScreen().tabItem{
                    Label("首页", systemImage: .house)
                }
                Text("社区").tabItem{
                    Label("社区", systemImage: .circle)
                }
                ProfileScreen().tabItem{
                    Label("我的", systemImage: .person)
                }
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
