//
//  ContentView.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/6/12.
//

import SwiftUI

struct ContentView: View {
    @State var view: AppRouter
    @Binding var path: NavigationPath
    
    var body: some View {
        switch view {
        case .HomeScreen:
            HomeScreen(path: $path)
        case .ProfileScreen:
            ProfileScreen(path: $path)
        case .SystemSettingScreen:
            SystemSettingScreen(path: $path)
        case .AccountBindingView:
            AccountBindingView()
        case .GeneralSettingView:
            GeneralSettingView()
        case .PersonalDetailView:
            PersonalDetailView()
        case .AboutView:
            AboutView(path: $path)
        case .ACRView:
            ACRView()
        case .LoginScreen:
            LoginScreen(path: $path)
        case .RegisterScreen:
            RegisterScreen()
        case .UserAgreementScreen:
            UserAgreementScreen()
        case .PhoneNumberLoginView:
            PhoneNumberLoginView(path: $path)
        case .OTPVerificationView:
            OTPVerificationView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(view: AppRouter
            .HomeScreen, path: .constant(NavigationPath()))
    }
}
