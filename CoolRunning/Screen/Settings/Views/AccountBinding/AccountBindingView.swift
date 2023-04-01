//
//  AccountBindingView.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/11.
//

import SwiftUI

// MARK: 绑定账号详情页
struct AccountBindingView: View {
    
    // 绑定信息
    @State var isQQBingding = true
    @State var isGitHubBingding = false
    @State var isWeiboBingding = false
    
    // 用户信息
    @AppStorage("user_image") var userImage: String = "me"
    @AppStorage("user_phone_number") var userPhoneNumber: String = "19916927751"
    @AppStorage("user_email") var userEmail: String = "1369352274@qq.com"

    var body: some View {
        ZStack {
            Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255).edgesIgnoringSafeArea(.all)
            Form {
                Section {
                    listItem(itemImage: "", itemName: "手机号", itemContent: userPhoneNumber)
                    listItem(itemImage: "", itemName: "邮箱", itemContent: userEmail)
                    listItem(itemImage: "", itemName: "修改密码", itemContent: "")
                }
                Section(header: Text("第三方账号")) {
                    Toggle(isOn: $isWeiboBingding) {
                        Text("QQ")
                    }
                    Toggle(isOn: $isQQBingding) {
                        Text("微信")
                    }
                    Toggle(isOn: $isGitHubBingding) {
                        Text("GitHub")
                    }
                }.padding(.vertical, 5)
                Section {
                    cancelAccount
                }
            }.navigationBarTitle("账号绑定", displayMode: .inline)
        }
    }
}

// MARK: Components
extension AccountBindingView {
    // 注销账号
    private var cancelAccount: some View {
        Button(action: {
        }) {
            Text("注销账号")
                .padding(10)
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
                .foregroundColor(.red)
                .font(.headline)
        }
    }
}

// MARK: Functions
extension AccountBindingView {
    /// 栏目结构
    func listItem(itemImage: String, itemName: String, itemContent: String) -> some View {
        Button(action: {
        }) {
            HStack {
                Image(systemName: itemImage)
                    .font(.body)
                    .foregroundColor(.black)
                Text(itemName)
                    .foregroundColor(.black)
                    .font(.body)
                Spacer()
                Text(itemContent)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.vertical, 8)
        }
    }
}

struct AccountBindingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountBindingView()
    }
}
