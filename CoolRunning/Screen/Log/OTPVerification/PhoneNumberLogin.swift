
// MARK: TO DO
/*
  1. 手机号码验证
  2. 安全验证页面
  3. 跳转下一个页面之前，提醒用户勾选用户需知
 */
import SwiftUI

struct PhoneNumberLogin: View {
    
    @State private var phoneNumber: String = ""
    @State private var didAgreen = false
    @State private var showSheets = false
    @State private var shouldNavigateToVerificationView = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                numbertTxtField
                userAgreenment
                nextButton
                Spacer()
            }
            .padding(.horizontal)
            
            VStack {
                Spacer()
                if showSheets {
                    TextAlert(text: "请先同意勾选用户协议")
                }
            }
        }
    }
}

// MARK: Components
extension PhoneNumberLogin {
    var numbertTxtField: some View {
        VStack(alignment: .leading) {
            Text("输入手机号码")
                .font(.largeTitle)
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
            .font(.title2)
            Divider()
        }
        .padding(.horizontal, 10)
    }
    // 用户须知同意
    var userAgreenment: some View {
         return HStack {
            Image(systemName: "checkmark.circle.fill")
                 .font(.headline)
                 .foregroundColor(didAgreen ? .purple : .gray)
                 .onTapGesture {
                     didAgreen.toggle()
                 }
                
            Text("已阅读并同意")
            NavigationLink("服务协议", destination: UserAgreementScreen())
                .foregroundColor(.purple)
            Text("和")
            NavigationLink("CoolRunning隐私保护指引", destination: Text("CoolRunning隐私保护指引"))
                .foregroundColor(.purple)
            Spacer()
        }
        .font(.caption)
        .padding(10)
    }
    // 短信验证码界面跳转
    var nextButton: some View {
//        NavigationLink(destination: OTPVerificationView(), label: {
//            Text("下一步")
//                .font(.title2)
//                .foregroundColor(.white)
//                .bold()
//                .frame(height: 27)
//                .frame(maxWidth: UIScreen.main.bounds.width)
//                .padding()
//        })
//        .background(
//            RoundedRectangle(cornerRadius: 10)
//                .frame(maxWidth: .infinity)
//                .foregroundColor(.purple)
//        )
        
//        Button {
//            if !didAgreen {
//                if !showSheets {
//                    showSheets.toggle()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
//                        // 弹窗持续判断条件
//                        showSheets = false
//                    })
//                }
//            } else {
//                // 跳转到OTPVerificationView(）
//
//            }
//        } label: {
//            Text("下一步")
//                .font(.title2.bold())
//                .frame(height: 30)
//                .frame(maxWidth: .infinity)
//        }
//        .controlSize(.large)
//        .buttonBorderShape(.roundedRectangle(radius: 10))
//        .buttonStyle(.borderedProminent)
        Group {
            NavigationLink("", destination: OTPVerificationView(), isActive: $shouldNavigateToVerificationView)
        
            Button {
                if !didAgreen {
                    if !showSheets {
                        showSheets.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                            // 弹窗持续判断条件
                            showSheets = false
                        })
                    }
                } else {
                    // 跳转到OTPVerificationView(）
                    shouldNavigateToVerificationView = true // 点击按钮时触发导航链接
                }
              
            } label: {
                Text("下一步")
                    .font(.title2.bold())
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
            }
            .controlSize(.large)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .buttonStyle(.borderedProminent)
        }
    }
    
}

// MARK: Functions
extension PhoneNumberLogin {
    
}

struct PhoneNumberLogin_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberLogin()
    }
}
