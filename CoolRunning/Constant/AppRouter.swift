//
//  AppRouter.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/6/12.
//

import SwiftUI

enum AppRouter: String {

    // 登陆状态
    case HomeScreen
    case ProfileScreen
    case SystemSettingScreen
    case AccountBindingView
    case GeneralSettingView
    case PersonalDetailView
    case AboutView
    case ACRView

    // 未登陆状态
    case LoginScreen
    case RegisterScreen
    case UserAgreementScreen
    case PhoneNumberLoginView
    case OTPVerificationView
}

//static var pathes: [any View] = [
//    OpeningScreen(),
//
//    // 登陆状态
//    HomeScreen(),
//    ProfileScreen(path: .constant(NavigationPath())),
//    SystemSettingScreen(),
//    AccountBindingView(),
//    GeneralSettingView(),
//    PersonalDetailView(),
//    AboutView(),
//    ACRView(),
//
//    // 未登陆状态
//    LoginScreen(),
//    RegisterScreen(),
//    UserAgreementScreen(),
//    PhoneNumberLoginView(),
//    OTPVerificationView()
//
//]

