
import SwiftUI

extension View {
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
}

