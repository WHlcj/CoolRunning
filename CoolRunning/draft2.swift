import SwiftUI

struct ProfileView: View {

    var body: some View {
        ZStack {
            Circle()
                .frame(width: 100, height: 100)
                .overlay(
                    ZStack {
                        Circle()
                            .stroke(
                                RadialGradient(
                                    gradient: Gradient(colors: [.purple, .cyan]),
                                    center: .topLeading,
                                    startRadius: 0,
                                    endRadius: 180), lineWidth: 8)
                        // 中间两竖
                        HStack(spacing: 15) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(RadialGradient(
                                    gradient: Gradient(colors: [.purple, .cyan]),
                                    center: .topLeading,
                                    startRadius: 0,
                                    endRadius: 55))
                                .frame(width: 15, height: 50)
                            RoundedRectangle(cornerRadius: 10)
                                .fill(RadialGradient(
                                    gradient: Gradient(colors: [.purple, .cyan]),
                                    center: .topLeading,
                                    startRadius: 0,
                                    endRadius: 80))
                                .frame(width: 15, height: 50)
                        }
                        .foregroundColor(.green)
                    }
                )
                .foregroundColor(.white)
        }
    }
}


struct draft2_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

