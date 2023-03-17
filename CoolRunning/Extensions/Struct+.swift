
import SwiftUI

/// app的消息提醒弹窗
struct TextAlert: View {
    @Binding var text: String
    @Binding var value: Bool
    var body: some View {
        HStack {
            Image("icon1")
                .resizable()
                .scaledToFill()
                .frame(width: 25, height: 25)
            Text(text)
                .font(.body)
                .foregroundColor(.black)
        }
        .padding(.all, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
            )
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                    // 弹窗持续判断条件
                    value = false
                })
            }
            .transition(.asymmetric(insertion: .scale.animation(.spring()), removal: .opacity.animation(.spring())))
    }
}

/// 普通文字输入框
/// 主要用于登录和注册页面的信息输入框
struct OrdinaryTextField: View {
    
    var title: String
    var placeholder: String
    var bindingValue: Binding<String>
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal,7)
                .padding(.bottom, -6)
                .padding(.top, 5)
                .foregroundColor(Color.white.opacity(0.9))
            HStack {
                TextField(placeholder, text: bindingValue)
                    .padding(.leading)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.brightness(0.3))
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Spacer()
                            Button {
                                value = ""
                            } label: {
                                Image(systemName: "xmark")
                            }
                            .padding(.horizontal, 15)
                            .foregroundColor(.gray)
                            .opacity(value.count == 0 ? 0 : 1)
                    })
            }
        }
        .foregroundColor(.black)
    }
}

/// 安全输入框
/// 主要用于登录和注册页面的信息输入框
struct SecureTextField: View {
    
    var title: String
    var placeholder: String
    var bindingValue: Binding<String>
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal,7)
                .padding(.bottom, -6)
                .padding(.top, 5)
                .foregroundColor(Color.white.opacity(0.9))
            HStack {
                SecureField(placeholder, text: bindingValue)
                    .padding(.leading)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.brightness(0.3))
                    .cornerRadius(10)
                    .overlay(
                        HStack {
                            Spacer()
                            Button {
                                value = ""
                            } label: {
                                Image(systemName: "xmark")
                            }
                            .padding(.horizontal, 15)
                            .foregroundColor(.gray)
                            .opacity(value.count == 0 ? 0 : 1)
                    })
            }
        }
        .foregroundColor(.black)
    }
}





