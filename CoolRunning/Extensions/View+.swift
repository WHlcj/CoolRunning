//
//  View+.swift
//  CoolRunning
//
//  Created by Changjun Li on 2023/3/8.
//

import SwiftUI

extension View {
    ///   模仿navilink的返回键
    func backToolBar(dismiss: DismissAction) -> some View {
        return toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .bold()
                        .padding(.leading, -9)
                    Text("Back")
                        .padding(.leading, -5)
                }
            }
        }
    }
 
    /// 用于PersonalDetailView 更换头像
    func modifyImage() -> some View {
        self
        .scaledToFill()
        .frame(width: 150, height: 150)
        .overlay(ZStack {
            VStack {
                Spacer()
                Text("更换头像")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: 140)
                    .frame(maxHeight: 30)
                    .background(Color.black)
                    .opacity(0.5)
            }
            Circle().stroke(Color.white, lineWidth: 5)
        })
        .clipShape(Circle())
    }    

//    func bg() -> some View {
//        RadialGradient(
//            gradient: Gradient(colors: [.purple, .cyan]),
//            center: .topLeading,
//            startRadius: 10,
//            endRadius: UIScreen.main.bounds.height)
//    }
}
