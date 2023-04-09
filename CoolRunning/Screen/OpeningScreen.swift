
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
    
    var body: some View {
        ZStack {
            //background
            RadialGradient(
                gradient: Gradient(colors: [.purple, .cyan]),
                center: .topLeading,
                startRadius: 10,
                endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()

            // content
            switch currentUserSignedIn {
            case true:
                HomeScreen()
                    .transition(.moveTtoT)
            case false:
                LoginScreen()
                    .transition(.moveTtoT)
            }
        }
    }
}

struct OpeningScreen_Previews: PreviewProvider {
    static var previews: some View {
        OpeningScreen()
    }
}

