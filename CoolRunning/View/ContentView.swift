
import SwiftUI

struct ContentView: View {
    @State var view: AppRouter
    /// App导航路由
    @Binding var path: NavigationPath
    
    var body: some View {
        switch view {
        case .HomeView:
            HomeView(path: $path)
        case .ProfileView:
            ProfileView(path: $path)
        case .SystemSettingView:
            SystemSettingView(path: $path)
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
        case .LoginView:
            LoginView(path: $path)
        case .RegisterView:
            RegisterView()
        case .UserAgreementView:
            UserAgreementView()
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
            .HomeView, path: .constant(NavigationPath()))
    }
}
