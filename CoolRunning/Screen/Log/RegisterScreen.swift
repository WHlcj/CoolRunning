
import SwiftUI
import AGConnectCore
import AGConnectCredential
import HMFoundation
import AGConnectAuth


/*
 // MARK: TO DO
 1. 邮箱验证
 2. 短信验证
 4. 验证输入内容与格式
 */

struct RegisterScreen: View {
    
    //MARK: AddGenderInit
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.purple)
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    @Environment(\.dismiss) private var dismiss
    // Page change
    @State var registerState: Int = 0
    @EnvironmentObject var viewRounter: LoginViewRounter
    
    // 注册信息
    @State private var username = ""
    @State private var password = ""
    @AppStorage("age") var age = 25.0
    @AppStorage("gender") var gender = ""
    @State private var phoneNumber = ""
    @State private var countryCode = ""
    @State private var verifyCode = ""

    // 短信按钮倒计时
    @State private var timeRemaining = 60
    @State private var isTimerActive = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // For the alert
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    // 数据库原型
    @State var dataArray: [String] = []
    
    // 输入聚焦
    @FocusState private var fieldInFocus: RegisterField?
    
    // MARK: MainBody
    var body: some View {
        ZStack {
            //background
            RadialGradient(
                gradient: Gradient(colors: [.purple, .cyan]),
                center: .topLeading,
                startRadius: 10,
                endRadius: UIScreen.main.bounds.height)
                .ignoresSafeArea()
            
            //content
            VStack {
                switch registerState {
                case 0:
                    registerTextField
                        .transition(.moveTtoL)
                case 1:
                    addAgeSection
                        .transition(.moveTtoL)
                case 2:
                    addGenderSection
                        .transition(.moveTtoL)
                default:
                    Rectangle()
                        .foregroundColor(.green)
                }
                Spacer()
                registerButton
            }
        }
    }
}

enum RegisterField {
    case username
    case password
    case phoneNumber
    case OTPcode
}

// MARK: Component
extension RegisterScreen {
    
    private var welcomeSection: some View {
        HStack {
            VStack {
                Text("注册")
                    .font(.largeTitle.bold())
                    .padding(.horizontal, 15)
                Text("Register")
                    .font(.title2.bold())
                    .padding(.horizontal, 20)
            }
            .foregroundColor(.white)
            Spacer()
        }
        .padding(.bottom, 40)
        .padding(.top)
    }
    

    
    private var registerTextField: some View {
        VStack(alignment: .leading) {
            welcomeSection
            OrdinaryTextField(title: "用户名:", placeholder: "Add your username here", bindingValue: $username, value: $username)
            SecureTextField(title: "密码:", placeholder: "Add your password here", bindingValue: $password, value: $password)
            SecureTextField(title: "密码:", placeholder: "Add your password here", bindingValue: $password, value: $password)
            OrdinaryTextField(title: "手机号码:", placeholder: "+86", bindingValue: $phoneNumber, value: $phoneNumber)
            OTPTextAndButton
        }
        .font(.title3)
        .padding(.horizontal, 25)
    }
    
    // 短信验证码和发送按钮
    private var OTPTextAndButton: some View {
        VStack(alignment: .leading) {
            Text("短信验证码:")
                .font(.headline)
                .padding(.horizontal,7)
                .padding(.bottom, -6)
                .padding(.top, 5)
                .foregroundColor(Color.white.opacity(0.9))
            HStack {
                TextField("xxxx", text: $verifyCode)
                    .padding(.leading)
                    .frame(height: 55)
                    .frame(maxWidth: UIScreen.main.bounds.width / 2.5)
                    .background(Color.gray.brightness(0.3))
                    .cornerRadius(10)
                Spacer()
                Button {
                    timeRemaining = 60
                    isTimerActive = true
                } label: {
                    Text(isTimerActive ? "\(timeRemaining)s 后重试" : "获取验证码")
                        .bold()
                        .frame(maxHeight: 25)
                        .frame(maxWidth: UIScreen.main.bounds.width / 3)
                }
                .disabled(isTimerActive)
                .controlSize(.large)
                .buttonBorderShape(.roundedRectangle(radius: 10))
                .buttonStyle(.borderedProminent)
                .onReceive(timer) { time in
                    guard isTimerActive else { return }
                    if timeRemaining > 1 {
                        timeRemaining -= 1
                    } else {
                        isTimerActive = false
                    }
                }
            }
        }
    }
    // 返回和注册按钮
    private var registerButton: some View {
        VStack {
            Button {
                handleReturnButtonPressed()
            } label: {
                Text("return".uppercased())
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(Color.cyan)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            Button(action: {
                handleNextButtonPressed()
            }, label: {
                Text("Register".uppercased())
                    .padding(15)
                    .frame(maxWidth: .infinity)
                    .background(textIsAppropriate() ? Color.purple : Color.gray)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .font(.headline)
            })
            .disabled(!textIsAppropriate())
        }
        .padding(.horizontal, 25)
    }
    
    // MARK: CaseView
    private var addAgeSection: some View {
        VStack(spacing: 20) {
            welcomeSection
            Spacer()
            
            Text("What's your age?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)

            Text(String(format: "%.0f", age))
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Slider(
                value: $age,
                in: 15...100,
                step: 1)
            .tint(.white)
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 25)
    }

    private var addGenderSection: some View {
        VStack(spacing: 20) {
            welcomeSection
            Spacer()
            
            Text("What's your gender?")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Picker("Select a gender", selection: $gender) {
                Text("Male").tag("Male")
                Text("Female").tag("Female")
                Text("Non-Binary").tag("Non-Binary")
            }
            .background(Color.white)
            .cornerRadius(8)
            .pickerStyle(.segmented)
            Spacer()
            Spacer()
        }
        .padding(.horizontal, 25)
    }
}

// MARK: Functions
extension RegisterScreen {
    
    func handleNextButtonPressed() {
        // Check Input
        switch registerState {
        case 0:
            guard username.count >= 3 else {
                showAlert(title: "Your name must be at least 3 characters long!")
                return
            }
        case 2:
            guard gender.count > 1 else {
                showAlert(title: "Please select a gender before moving forward!")
                return
            }
        default:
            break
        }
        
        // Go to next section
        if registerState == 2 {
            showAlert(title: "登录成功!")
        } else {
            withAnimation(.spring()) {
                registerState += 1
            }
        }
    }
    
    func handleReturnButtonPressed() {
        withAnimation(.spring()){
            if registerState == 0 {
                viewRounter.currentView = .login
            } else {
                registerState -= 1
            }
        }
    }
    
    func textIsAppropriate() -> Bool {
        if username.count >= 3 {
            return true
        }
        return false
    }
    
    func save() {
        dataArray.append(username)
        username = ""
    }
    
    func showAlert(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
}

// MARK: Preview
struct Register_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
