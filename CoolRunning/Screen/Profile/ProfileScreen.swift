
// TO DO
/*
  1. toolbar简化
 */

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        NavigationView {
            ZStack{
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    systemBar
                }
            }

        }
 
    }
}

// MARK: Components
extension ProfileScreen {
    
    var profile: some View {
        VStack {
            
        }
    }
    
    // 设置按钮
    var systemBar: some View {
        NavigationLink (
            destination: SystemSettingScreen(),
            label:    {
                Image(systemName: "gearshape")        .font(.title2)
                    .foregroundColor(.gray)
            }
        )
    }
    
}

struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
    }
}
