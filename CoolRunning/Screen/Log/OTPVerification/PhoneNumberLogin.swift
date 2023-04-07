
// MARK: TO DO
/*
  1. 手机号码验证
  2. 安全验证页面
 */
import SwiftUI

struct PhoneNumberLogin: View {
    
    @State private var phoneNumber: String = ""
    @State private var checkmarkColor = Color.gray
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            VStack(alignment: .leading) {
                numbertTxtField
                userAgreenment
                nextButton
                Spacer()
            }
            .padding(.horizontal)
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
    
    var userAgreenment: some View {
         return HStack {
            Image(systemName: "checkmark.circle.fill")
                 .font(.headline)
                 .foregroundColor(checkmarkColor)
                 .onTapGesture {
                     checkmarkColor == .gray ? (checkmarkColor = .purple) : (checkmarkColor = .gray)
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
    
    var nextButton: some View {
        NavigationLink(destination: OTPVerificationView(), label: {
            Text("下一步")
                .font(.title2)
                .foregroundColor(.white)
                .bold()
                .frame(height: 27)
                .frame(maxWidth: UIScreen.main.bounds.width)
                .padding()
        })
        .background(
            RoundedRectangle(cornerRadius: 10)
                .frame(maxWidth: .infinity)
                .foregroundColor(.purple)
        )
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
