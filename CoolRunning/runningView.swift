///*
//  北京: latitude:39.916527,longitude:116.397128
// */
//
//import SwiftUI
//import MapKit
//
//struct RunningView: View {
//    @Environment(\.dismiss) var dismiss
//    @StateObject private var vm = MKMapVM()
//    
//    // 跑步暂停按钮动画控件
//    @State private var isLocking = false
//    @State private var removeButton = false
//    @State private var changeButtonIcon = false
//
//    // 控件颜色
//    var ButtonColor = RadialGradient(
//        gradient: Gradient(colors: [.purple, .cyan]),
//        center: .topLeading,
//        startRadius: 0,
//        endRadius: 180)
//
//    var body: some View {
//        ZStack {
//            switch vm.currentState {
//            case .Preparing:
//                CountdownView()
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5, execute: {
//                            vm.currentState = .Running
//                        })
//                    }
//            default:
//                runningView
//            }
//        }
//    }
//}
//
//extension RunningView {
//
//    var runningView: some View {
//        ZStack {
//            vm.mapView
//                .ignoresSafeArea()
//                .onAppear {
//                    vm.startRunning()
//                }
//            VStack {
//                header
//                Spacer()
//                runningButtons
//            }
//        }
//    }
//
//    var header: some View {
//        HStack(alignment: .bottom) {
//            VStack(spacing: 13) {
//                Text(FormatDisplay.distance(vm.distance))
//                    .font(.title)
//                    .fontWeight(.medium)
//                    .foregroundColor(.black)
//                Text("已跑公里")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//            .frame(maxWidth: 100)
//            Divider()
//            infoCell(info: FormatDisplay.time(vm.seconds), title: "时长")
//                .frame(width: 100)
//            infoCell(info: FormatDisplay.speed(distance: vm.distance, seconds: vm.seconds), title: "配速")
//            infoCell(info: "121", title: "步频")
//        }
//        .frame(height: 50)
//        .frame(maxWidth: .infinity, alignment: .center)
//        .padding(.horizontal)
//        .padding(.bottom, 20)
//        .background(
//            Color.white
//        )
//    }
//    // 单条跑步信息
//    func infoCell(info: String, title: String) -> some View {
//        VStack(spacing: 13) {
//            Text(info)
//                .font(.title2)
//                .fontWeight(.medium)
//                .foregroundColor(.black)
//            Text(title)
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//        .frame(maxWidth: 100)
//    }
//    // 跑步按钮总控
//    var runningButtons: some View {
//        VStack {
//            switch vm.currentState {
//            case .Running:
//               runningState
//            case .Pause:
//                pauseState
//            default:
//                Button {
//                    withAnimation(.easeInOut(duration: 0.2)){
//                        vm.currentState = .Running
//                    }
//                } label: {
//                    Text("Preparing or isEnded")
//                }
//            }
//        }
//        .padding(.bottom, 60)
//    }
//    // 跑步状态按钮
//    var runningState: some View {
//        HStack(spacing: 30) {
//            if isLocking {
//                unlockSlider
//            } else if !removeButton {
//                Circle()
//                    .fill(.clear)
//                    .frame(width: 50, height: 50)
//                stopButton
//                lockButton
//            }
//        }
//    }
//    // 锁定按钮
//    var lockButton: some View {
//        Button {
//            // 切换到锁定状态时先更改Image
//            changeButtonIcon.toggle()
//            withAnimation(.easeInOut(duration: 0.6)){
//                removeButton = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    isLocking.toggle()
//                }
//            }
//        } label:{
//            Image(systemName: changeButtonIcon ? "lock.circle.fill" : "lock.circle")
//                .resizable()
//                .frame(width: 40, height: 40)
//                .tint(ButtonColor)
//                .background(
//                    Circle()
//                        .fill(.white)
//                        .frame(width: 35, height: 35)
//                )
//        }
//        .transition(.asymmetric(insertion: .opacity, removal: .offset(x: -200).animation(.linear(duration: 0.4))))
//    }
//    // 解锁按钮
//    var unlockSlider: some View {
//        HStack {
//            StopSliderView(controlValue: $isLocking)
//                .frame(width: 240, height: 45)
//        }
//        .frame(width: 85, height: 85)
//        .transition(.asymmetric(insertion: .opacity.animation(.easeIn(duration: 0.6)), removal: .opacity.animation(.easeInOut(duration: 0.2))))
//        .onAppear {
//            changeButtonIcon = false
//        }
//        .onDisappear {
//            removeButton = false
//        }
//    }
//    // 暂停状态按钮
//    var pauseState: some View {
//        HStack(spacing: 20) {
//            // 继续跑步按钮
//            Button {
//                withAnimation(.easeInOut(duration: 0.2)){
//                    vm.startRunning()
//                }
//            } label: {
//                Image(systemName: "arrowtriangle.right.circle.fill")
//                    .resizable()
//                    .frame(width: 75, height: 75)
//                    .tint(.green)
//                    .background(
//                        Circle()
//                            .fill(.white)
//                            .frame(width: 40, height: 40)
//                    )
//            }
//            // 结束跑步按钮
//            Button {
//                vm.stopRunning()
//                withAnimation(.easeInOut(duration: 0.2)){
//                    dismiss()
//                }
//            } label: {
//                Image(systemName: "stop.circle.fill")
//                    .resizable()
//                    .frame(width: 75, height: 75)
//                    .tint(.red)
//                    .background(
//                        Circle()
//                            .fill(.white)
//                            .frame(width: 40, height: 40)
//                    )
//            }
//        }
//        .transition(.asymmetric(insertion: .scale(scale: 0.6), removal: .scale(scale: 0.6)))
//    }
//    // 暂停跑步按钮
//    var stopButton: some View {
//        Button {
//            withAnimation(.easeInOut(duration: 0.2)) {
//                vm.stopRunning()
//            }
//        } label: {
//            // 主要形状
//            Circle()
//                .stroke(ButtonColor, lineWidth: 8)
//                .frame(width: 85, height: 85)
//                .overlay(
//                    // 中间两竖
//                    HStack(spacing: 7) {
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(ButtonColor)
//                            .frame(width: 9, height: 30)
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(ButtonColor)
//                            .frame(width: 9, height: 30)
//                    }
//                )
//                .background(Color.white)
//                .clipShape(Circle())
//                .offset(y: 5)
//        }
//        .transition(.asymmetric(insertion: .scale(scale: 0.7), removal: AnyTransition.opacity.animation(.easeInOut(duration: 0.1))))
//    }
//}
//
//struct RunningView_Previews: PreviewProvider {
//    static var previews: some View {
//        RunningView()
//    }
//}
