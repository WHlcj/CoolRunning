
// MARK: TO DO
/*
 1. 登出时，所有信息清空（账号密码等@AppStorage和UserDefault信息）
 2. 搞懂@标记的意思
 3. 给以往的函数（尤其是Extension）加上参数注释
 4. 解决NavigationView导致的导航错乱
 */

import SwiftUI

struct OpeningScreen: View {
    
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    @State var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            // content
            switch currentUserSignedIn {
            case true:
                ContentView(view: AppRouter.HomeScreen, path: $path)
                    .transition(.moveTtoT)
            case false:
                ContentView(view: AppRouter.LoginScreen, path: $path)
                    .transition(.moveLtoL)
            }
        }
    }
}

struct OpeningScreen_Previews: PreviewProvider {
    static var previews: some View {
        OpeningScreen()
    }
}

