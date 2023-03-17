//
//  ACRView.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/11.
//

import SwiftUI
// About CoolRunning View
struct ACRView: View {
    var body: some View {
        ZStack {
            // background
            
            // content
            VStack {
                Form {
                    Section {
                        textButton(text: "加入我们")
                        textButton(text: "申诉举报")
                        textButton(text: "CoolRunning证照信息")
                    } header: {
                        topItem
                            .frame(maxWidth: .infinity)
                            .padding(.bottom, 10)
                    }
                }
                Spacer()
            }
        }
        .navigationTitle("关于CoolRunning")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: Component
extension ACRView {
    var topItem: some View {
        VStack {
            Image("icon1")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .padding(.bottom, 5)
            Text("CoolRunningV1.0.0")
                .foregroundColor(.gray)
                
        }
    }
}

// MARK: Functions
extension ACRView {
    func textButton(text: String) -> some View {
        Button {

        } label: {
            Text(text)
                .foregroundColor(.black)
                .font(.body)
                .padding(.vertical, 8)
        }
    }
}

struct ACRView_Previews: PreviewProvider {
    static var previews: some View {
        ACRView()
    }
}
