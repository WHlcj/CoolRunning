
// MARK: TO DO
/*
 1. 登出时，所有信息清空（账号密码等@AppStorage和UserDefault信息）
 2. 搞懂@标记的意思
 4. 解决NavigationView导致的导航错乱
 */

import SwiftUI

struct OpeningView: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            switch currentUserSignedIn {
            case true:
                ContentView(view: AppRouter.HomeView, path: $path)
                    .transition(.moveTtoT)
            case false:
                ContentView(view: AppRouter.LoginView, path: $path)
                    .transition(.moveLtoL)
            }
        }
    }
}

struct OpeningView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningView()
    }
}

