/*
  北京: latitude:39.916527,longitude:116.397128
 */

/*
 TO DO:
 1. UI美化工作
 2. 防触控按钮
 3. 整理主页窗口跳转
 */
import SwiftUI
import MapKit

struct RunningTestView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = MKMapViewModel()

    var body: some View {
        ZStack {
            Color.blue
            VStack {
                Spacer()
                runningButton
            }
        }
    }
    // 跑步按钮控制
    var runningButton: some View {
        VStack {
            switch vm.currentState {
            case .Running:
               runningState
            case .Pause:
                pauseState
            default:
                Button {
                    withAnimation(.easeInOut(duration: 0.2)){
                        vm.currentState = .Running
                    }
                } label: {
                    Text("Preparing or isEnded")
                }
            }
        }
        .padding(.bottom, 60)
    }
    // 跑步状态按钮
    var runningState: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                vm.stopRunning()
            }
        } label: {
            stopButton
        }
        .transition(.asymmetric(insertion: .scale(scale: 0.7), removal: AnyTransition.opacity.animation(.easeInOut(duration: 0.1))))
    }
    // 暂停状态按钮
    var pauseState: some View {
        HStack(spacing: 20) {
            // 继续跑步按钮
            Button {
                withAnimation(.easeInOut(duration: 0.2)){
                    vm.startRunning()
                }
            } label: {
                Image(systemName: "arrowtriangle.right.circle.fill")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .tint(.green)
                    .background(
                        Circle()
                            .fill(.white)
                            .frame(width: 40, height: 40)
                    )
            }
            // 结束跑步按钮
            Button {
                vm.stopRunning()
                withAnimation(.easeInOut(duration: 0.2)){
                    dismiss()
                }
            } label: {
                Image(systemName: "stop.circle.fill")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .tint(.red)
                    .background(
                        Circle()
                            .fill(.white)
                            .frame(width: 40, height: 40)
                    )
            }
        }
        .transition(.asymmetric(insertion: .scale(scale: 0.6), removal: .scale(scale: 0.6)))
    }
    // 暂停跑步按钮
    var stopButton: some View {
        // 主要形状
        Circle()
            .stroke(
                RadialGradient(
                    gradient: Gradient(colors: [.purple, .cyan]),
                    center: .topLeading,
                    startRadius: 0,
                    endRadius: 180), lineWidth: 8)
            .frame(width: 85, height: 85)
            .overlay(
                // 中间两竖
                HStack(spacing: 7) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(RadialGradient(
                            gradient: Gradient(colors: [.purple, .cyan]),
                            center: .topLeading,
                            startRadius: 0,
                            endRadius: 55))
                        .frame(width: 9, height: 30)
                    RoundedRectangle(cornerRadius: 10)
                        .fill(RadialGradient(
                            gradient: Gradient(colors: [.purple, .cyan]),
                            center: .topLeading,
                            startRadius: 0,
                            endRadius: 80))
                        .frame(width: 9, height: 30)
                }
            )
            .background(Color.white)
            .clipShape(Circle())
            .offset(y: 5)
    }
    
}

struct RunningTestView_Previews: PreviewProvider {
    static var previews: some View {
        RunningTestView()
    }
}
