
import SwiftUI

struct OTPVerificationView: View {
    
    /// 验证码输入
    @State private var otpText: String = ""
    
    /// 未开发完全时，预设验证码，测试用
    let otpPin = "111000"
    
    /// 键盘状态
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                otpTextBoxes
                otpButton
            }
            .padding()
            .frame(maxHeight: .infinity, alignment: .top)
            
//            // 验证码提示框
//            .onAppear {
//                TextAlert(text: otpText, boolValue: <#Binding<Bool>#>)
//            }
        }
    }
}

// MARK: Components
extension OTPVerificationView {
    var otpTextBoxes: some View {
        VStack(alignment: .leading) {
            Text("短信验证码")
                .font(.title)
            HStack {
                // OTP输入框
                ForEach(0..<6, id: \.self) { index in
                    OTPBoxes(index)
                }
            }
            .background(
                TextField("", text: $otpText.limit(6))
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)// 键盘上接收短信验证码
                    .frame(width: 1, height: 1) //不能删，防止误触崩溃
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused($isKeyboardShowing)
            )
            .contentShape(Rectangle()) // 加强点触效果
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
        }
        .padding(.horizontal, 10)
        .toolbar {
            optToolBarItems
        }
    }
    /// 键盘的done按键
    private var optToolBarItems: some ToolbarContent {
        ToolbarItem(placement: .keyboard, content: {
            Button("Done") {
                isKeyboardShowing.toggle()
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        })
    }
    
    var otpButton: some View {
        VStack {
            Button {

            } label: {
                Text("验证")
                    .font(.title3.bold())
                    .frame(height: 50)
                    .frame(maxWidth: UIScreen.main.bounds.width)
            }
            .buttonStyle(.borderedProminent)
            .disabled(otpText.count < 6)
        }
        .padding(.top)
    }
    
}

// MARK: Functions
extension OTPVerificationView {
    /// 验证码输入框
    func OTPBoxes(_ index: Int) -> some View {
        let status = isKeyboardShowing && otpText.count == index
        return ZStack {
            if otpText.count > index {
                // 找到当前输入字符的排序
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            }
        }
        .frame(width: 45, height: 45)
        .background(
            // 高亮当前输入框
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? .purple : .gray, lineWidth: status ? 4 : 0.5)
        )
        .frame(maxWidth: .infinity)
    }
}

struct OTPverificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView()
    }
}
