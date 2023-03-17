
// MARK: TO DO
/*
  2. 打开应用时加载页面
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
            if currentUserSignedIn {
                HomeScreen()
                    .transition(.moveTtoT)
            } else {
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

