
import SwiftUI

struct MainView: View {
    
    /// 是否开始跑步
    @State var startRunning = false
    /// 跑步按钮的轻触形状变化
    @GestureState private var startButtonPressed = false
    
    var body: some View {
        VStack {
            headInfo
            Spacer()
            startRunningButton
        }
        .padding(.horizontal)
    }
}

// MARK: Components
extension MainView {
    /// 顶部信息
    var headInfo: some View {
        HStack {
            RunningAimCell()
            // 天气和GPS信息
            VStack {
                WeatherInfoCell()
                gpsInfo
            }
        }
    }
    /// GPS信息
    var gpsInfo: some View {
        HStack {
            Text("GPS")
            ForEach(0..<3, content: { number in
                Capsule(style: .circular)
                    .frame(width: 7, height: 12)
                    .padding(.horizontal, -2)
            })
            Text("强")
        }
        .foregroundColor(.green)
    }
    /// 运动开始按钮
    var startRunningButton: some View {
        Circle()
            .fill(RadialGradient(
                gradient: Gradient(colors: [.purple, .cyan]),
                center: .topLeading,
                startRadius: 0,
                endRadius: 180))
            .frame(width: startButtonPressed ? 140 : 120)
            .opacity(startButtonPressed ? 0.8 : 1)
            .overlay(
                Text("开始")
                    .font(.title)
                    .foregroundColor(.white)
            )
            .animation(.easeIn(duration: 0.1), value: startButtonPressed)
            .onTapGesture {
                startRunning.toggle()
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 60, maximumDistance: 1000.0)
                    .updating($startButtonPressed, body: { (currentState, state, transcation) in
                        state = currentState
                    })
            )
            .offset(y: startButtonPressed ? 10 : 0)
            .padding(.bottom, 20)
            .fullScreenCover(isPresented: $startRunning) {
                RunningView()
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
