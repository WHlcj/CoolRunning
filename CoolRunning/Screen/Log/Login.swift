//
//  Login.swift
//  CoolRunningUI
//
//  Created by Changjun Li on 2023/2/27.
//

import SwiftUI

struct LoginScreen: View {
    
    @State var Username = ""
    @State var Password = ""
    
    var body: some View {
        NavigationView {
              VStack {
                  //  backgroundImage
                    logIn
                        .padding(.horizontal)
              }
        }
        .navigationTitle("乐动校园")
    }
    
    // MARK: Background
    private var backgroundImage: some View {
        Image("icon1")
            .resizable()
            //.aspectRatio(contentMode: .fill)
            .scaledToFill()
            .ignoresSafeArea(edges: [.bottom, .top])
            .blur(radius: 10)
    }
    
    // MARK: LoginView
    private var logIn: some View {
        VStack {
            TextField("Username", text: $Username)

            TextField("Password", text: $Password)
        }
        .padding()
        .background(Color.gray.opacity(0.3).cornerRadius(10))
        .font(.title2)
    }
    
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
