
import SwiftUI

struct HomeScreen: View {
    
    @AppStorage("signed_in") var currentUserSignedIn = false
    @State private var selectedTabView = 1
    @Binding var path: NavigationPath
    
    var body: some View {
        TabView(selection: $selectedTabView) {
            RunningScreen().tabItem{
                Label("首页", systemImage: .house)
            }
            .tag(1)
            Text("社区").tabItem{
                Label("社区", systemImage: .circle)
            }
            .tag(2)
            ProfileScreen(path: $path).tabItem{
                Label("我的", systemImage: .person)
            }
            .tag(3)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()
        HomeScreen(path: $path)
    }
}




