
import SwiftUI

enum AppRouter: String {
    // 登陆状态
    case HomeView
    case ProfileView
    case SystemSettingView
    case AccountBindingView
    case GeneralSettingView
    case PersonalDetailView
    case AboutView
    case ACRView

    // 未登陆状态
    case LoginView
    case RegisterView
    case UserAgreementView
    case PhoneNumberLoginView
    case OTPVerificationView
}

