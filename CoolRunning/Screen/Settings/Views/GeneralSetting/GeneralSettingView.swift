//
//  GeneralSettingView.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/11.
//

import SwiftUI

struct GeneralSettingView: View {
    // MARK: 通用设置详情页
    @State var isFullSelected = true
    @State var isIndividuationSelected = true
    @State var isChoicenessSelected = true
    @State var isInformationSelected = true

    var body: some View {
        ZStack {
            // background
            Color(red: 246 / 255, green: 246 / 255, blue: 246 / 255).edgesIgnoringSafeArea(.all)
            
            // content
            Form {
                Section {
                    textToggle(title: "完整功能", caption: "开启后享受完整功能", binding: $isFullSelected)
                    textToggle(title: "个性化推荐", caption: "开启后将根据您的喜好进行内容推荐", binding: $isIndividuationSelected)
                    textToggle(title: "精选内容推送", caption: "开启后将享有精选内容推荐", binding: $isChoicenessSelected)
                    textToggle(title: "消息提醒", caption: "关闭后将无法收到及时通知", binding: $isInformationSelected)
                }
                .padding(.vertical, 5)
            }
            .navigationBarTitle("通用设置", displayMode: .inline)
        }
    }
}

// MARK: Functions
extension GeneralSettingView {
    func textToggle(title: String, caption: String, binding: Binding<Bool>) -> some View {
        Toggle(isOn: binding) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.body)
                    .foregroundColor(.black)
                Text(caption)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct GeneralSettingView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingView()
    }
}
