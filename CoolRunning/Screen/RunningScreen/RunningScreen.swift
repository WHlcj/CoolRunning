
import SwiftUI

struct RunningScreen: View {
    
    // 数据管理
    @State var runningGoal = 126.0
    @State var runningkm = 120.136
    @State var isRunning = false
    
    // 控制流
    @GestureState private var startButtonPressed = false
    @State var background: Bool = false
    
    var body: some View {
            
        VStack {
            header
            Spacer()
            startRunningButton
        }
        .padding(.horizontal)

    }
}

// MARK: Components
extension RunningScreen {

    // 左上跑步信息
    var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                runningOverViewTopText
                runningProgressBar
                runningOverViewBottomText
            }
            .padding(.horizontal)
            .padding(.vertical)
            .background(
                ZStack {
                    Color.white
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.purple, lineWidth: 6)
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(width: 230)
            // 天气
            VStack {
                Spacer()
                weatherInformation
                gpsInformation
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 120)
    }
    // 天气信息
    var weatherInformation: some View {
        HStack {
            Text("🌤️")
                .font(.largeTitle)
            Text("11℃")
                .font(.title)
                .foregroundColor(.gray)
        }
    }
    // GPS信息
    var gpsInformation: some View {
        HStack {
            Text("GPS")
                .font(.body)
            ForEach(0..<3, content: { number in
                Capsule(style: .circular)
                    .frame(width: 8, height: 12)
                    .padding(.horizontal, -2)
            })
        }
    }
    // 跑步进度条
    var runningProgressBar: some View {
        ProgressView(value: runningkm/runningGoal)
            .tint(
                RadialGradient(
                    gradient: Gradient(colors: [.purple, .cyan]),
                    center: .leading,
                    startRadius: 0,
                    endRadius: 300)
            )
            .padding(3)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.purple, lineWidth: 1.5)
            )
    }
    // 跑步信息顶部文字信息
    var runningOverViewTopText: some View {
        HStack(alignment: .bottom) {
            Image(systemName: "figure.run")
                .font(.largeTitle.bold())
            Text(String(format: "%.2f", runningkm))
                .font(.largeTitle.bold())
            Text("公里")
                .font(.body)
                .padding(.bottom, 8)
        }
        .foregroundColor(.black)
        .opacity(0.8)
    }
    // 跑步信息底部文字信息
    var runningOverViewBottomText: some View {
        HStack {
            Text("学期目标:")
                .foregroundColor(.gray)
            Text(String(format: "%.0f", runningGoal) + "公里")
                .opacity(0.8)
        }
    }
    // 运动开始按钮
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
                isRunning.toggle()
               // 待完善
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 60, maximumDistance: 1000.0)
                    .updating($startButtonPressed, body: { (currentState, state, transcation) in
                        state = currentState
                    })
            )
            .offset(y: startButtonPressed ? 10 : 0)
            .padding(.bottom, 20)
            .fullScreenCover(isPresented: $isRunning) {
                RunningView()
            }
    }
}

struct RunningScreen_Previews: PreviewProvider {
    static var previews: some View {
        RunningScreen()
    }
}
