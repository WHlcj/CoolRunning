
import SwiftUI

struct PhoneNumberLoginView: View {
    /// App导航路由
    @Binding var path: NavigationPath
    /// 用户输入的电话号码
    @State private var phoneNumber: String = ""
    @State private var didCheckAgreenment = false
    @State private var showSheets = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                numbertTxtField
                userAgreenment
                nextButton
                Spacer()
            }
            .padding(.horizontal)
            // app的消息提醒弹窗
            if showSheets {
                if !didCheckAgreenment {
                    TextAlert(text: "请先同意勾选用户协议")
                } else if !isValidChinesePhoneNumber(phoneNumber) {
                    TextAlert(text: "请输入有效的电话号码")
                }
            }
        }
    }
}

// MARK: Components
extension PhoneNumberLoginView {
    /// 电话号码填充栏
    private var numbertTxtField: some View {
        VStack(alignment: .leading) {
            Text("输入手机号码")
                .font(.title)
                .padding(.vertical)
            HStack {
                Text("+86")
                    .foregroundColor(.gray)
                    .padding(.trailing)
                TextField("请输入手机号码", text: $phoneNumber)
                Button {
                    phoneNumber = ""
                } label: {
                    Image(systemName: "xmark")
                }
                .foregroundColor(.gray)
                .opacity(phoneNumber.count == 0 ? 0 : 1)
            }
            .font(.title3)
            Divider()
        }
        .padding(.horizontal, 10)
    }
    /// 用户须知同意
    private var userAgreenment: some View {
        return HStack {
            SFSymbol.checkmark
                .font(.headline)
                .foregroundColor(didCheckAgreenment ? .purple : .gray)
                .onTapGesture {
                    didCheckAgreenment.toggle()
                }
            
            Text("已阅读并同意")
            NavigationLink("服务协议", destination: UserAgreementView())
                .foregroundColor(.purple)
            Text("和")
            NavigationLink("CoolRunning隐私保护指引", destination: Text("CoolRunning隐私保护指引"))
                .foregroundColor(.purple)
            Spacer()
        }
        .font(.caption)
        .padding(10)
    }
    /// 短信验证码界面跳转按钮
    private var nextButton: some View {
        Button {
            validAccess()
        } label: {
            Text("下一步")
                .font(.title3.bold())
                .frame(height: 50)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
    }
    
}

// MARK: - Functions
extension PhoneNumberLoginView {
    /// 验证是否勾选用户协议和手机号是否正确，验证成功则跳转到OTPVerificationView(）
    private func validAccess() {
        if !didCheckAgreenment || !isValidChinesePhoneNumber(phoneNumber) {
            if !showSheets {
                showSheets = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showSheets = false
                }
            }
        } else {
            path.append(AppRouter.OTPVerificationView)
        }
    }
    /// 验证电话号码是否有效
    private func isValidChinesePhoneNumber(_ phoneNumber: String) -> Bool {
        // 移除所有非数字字符
        let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        // 验证号码长度
        guard cleanedPhoneNumber.count == 11 else {
            return false
        }
        // 验证号码前缀
        let validPrefixes = ["13", "14", "15", "16", "17", "18", "19"]
        guard validPrefixes.contains(String(cleanedPhoneNumber.prefix(2))) else {
            return false
        }
        // 验证运营商号段
        let validSegments = [
            "130", "131", "132", "133", "134", "135", "136", "137", "138", "139",
            "144", "147", "149",
            "150", "151", "152", "153", "155", "156", "157", "158", "159",
            "165", "166",
            "170", "171", "172", "173", "174", "175", "176", "177", "178",
            "180", "181", "182", "183", "184", "185", "186", "187", "188", "189",
            "198", "199"
        ]
        guard validSegments.contains(String(cleanedPhoneNumber.prefix(3))) else {
            return false
        }
        // 验证通过
        return true
    }
}


struct PhoneNumberLoginView_Previews: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()
        PhoneNumberLoginView(path: $path)
    }
}
