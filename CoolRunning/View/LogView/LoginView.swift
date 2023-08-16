
// TO DO:
/*
  1. 短信验证码
  2. 忘记密码
  3. 邮箱登录
 */

import SwiftUI

enum OnboardingField {
    case username
    case password
}

struct LoginView: View {
    
    //page change
    @AppStorage("signed_in") var currentUserSignedIn = false
    @Binding var path: NavigationPath
    
    // login inputs
    @AppStorage("username") var Username = ""
    @State private var Password = ""
    
    @FocusState private var fieldInFocus: OnboardingField?
    
    //MARK: MainBody
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
                VStack {
                    header
                    logInTextField
                    Spacer()
                    logInButton
                }
                .padding(.horizontal, 25)
                .foregroundColor(.white)
            }
    } 
}


// MARK: Components
extension LoginView {
    // 顶部标题
    private var header: some View {
        HStack {
            VStack {
                Text("乐动校园")
                    .font(.largeTitle.bold())
                    .padding(.horizontal, 15)
                Text("Welcome!")
                    .font(.title2.bold())
                    .padding(.horizontal, 20)
            }
            Spacer()
        }
        .padding(.bottom, 40)
        .padding(.top)
    }

    var logInTextField: some View {
        VStack(alignment: .leading) {
            OrdinaryTextField(title: "账号:", placeholder: "Username", bindingValue: $Username, value: $Username) 
            SecureTextField(title: "密码:", placeholder: "Password", bindingValue: $Password, value: $Password)
            HStack {
                NavigationLink("忘记密码?", destination: Text("忘记密码"))
                Spacer()
                NavigationLink("手机号登录", value: AppRouter.PhoneNumberLoginView)
                    .navigationDestination(for: AppRouter.self) { page in
                        ContentView(view: page, path: $path)
                    }
            }
            .font(.headline)
            .foregroundColor(Color.cyan)
        }
        .font(.title3)
    }
    
    var logInButton: some View {
        VStack { // START: VS
            Button {
                withAnimation(.spring()) {
                    currentUserSignedIn = true
                }
            } label: {
                Text("登入")
                    .bold()
                    .frame(height: 30)
                    .frame(maxWidth: UIScreen.main.bounds.width / 2)
            }
            .controlSize(.large)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .buttonStyle(.borderedProminent)
            
            NavigationLink(value: AppRouter.RegisterView) {
                Text("注册")
                    .bold()
                    .frame(height: 30)
                    .frame(maxWidth: UIScreen.main.bounds.width / 2)
            }
            .controlSize(.large)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .buttonStyle(.bordered)

            Text("第三方账号登录")
                .font(.caption)
                .padding(.top)
                .padding(.bottom, -15)
            Capsule()
                .frame(width: UIScreen.main.bounds.width / 1.5, height: 1)
                .padding()
            HStack {
                NavigationLink(destination: Text("邮件登录"), label: {
                    Image(systemName: "envelope.fill")})
            }
        }// END: VS
        .font(.title2)
    }
}


// MARK: Functions
extension LoginView {
    

}



struct Login_Previews: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()
        LoginView(path: $path)
    }
}
