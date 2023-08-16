//
//  AboutView.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/11.
//

import SwiftUI

struct AboutView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
            VStack {
                Form {
                    textButton(text: "个人信息收集清单")
                    textButton(text: "第三方信息共享清单")
                    textButton(text: "隐私政策摘要")
                    textButton(text: "协议与条款")
                    NavigationLink(value: AppRouter.ACRView) {
                        textButton(text: "关于CoolRunning")
                    }
                }
            }
            .navigationTitle("关于")
            .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: Components
extension AboutView {
    
}

// MARK: Functions
extension AboutView {
    func textButton(text: String) -> some View {
        Button {

        } label: {
            Text(text)
                .foregroundColor(.black)
                .font(.body)
        }
        .padding(.vertical, 8)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        @State var path = NavigationPath()
        AboutView(path: $path)
    }
}
