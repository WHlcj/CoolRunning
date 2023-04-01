//
//  RunningView.swift
//  CoolRunning
//
//  Created by 何纪栋 on 2023/3/18.
//

/*
  速度格式修改为 0'0"这样
 */
import SwiftUI
import MapKit
import CoreLocation

struct RunningView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var vm = MapViewModel()
    
    @State private var timer: Timer?
    @State private var seconds = 0
    
    @State private var formattedSpeed = String()
    @State private var formattedDistance = String()
    @State private var formattedTime = String()
    
    @State var currentState = Run_State.Running
    
    
    var body: some View {
        ZStack {
            mapView
            VStack {
                Spacer()
                buttonSection
            }
        }
    }
    
    private var mapView: some View {
        Map(coordinateRegion: $vm.region, showsUserLocation: true, userTrackingMode: .constant(.follow))
            .ignoresSafeArea()
            .tint(Color(.systemGreen))
            .allowsHitTesting(false)
    }
    
    private var buttonSection: some View {
        VStack {
            Text("Distance: \(formattedDistance) km")
            Text("Time: \(formattedTime)")
            Text("Speed: \(formattedSpeed) min/km")
            
            switch currentState {
            case .Running:
                Button("暂停") {
                    changeState(newState: .Pause)
                }
            case .Pause:
                HStack {
                    Button("继续") {
                        changeState(newState: .Running)
                    }
                    Button("结束") {
                        changeState(newState: .Ending)
                    }
                }
            case .Preparing:
                Text("isPrepared")
            case .Ending:
                Text("isEnded")
            }
        }.onAppear {
            startTimer()
            vm.requestLocation()
        }
    }
    
    func startTimer() {
        //计时器创建,格式化后的数据伴随着计时器的更新一同更新在视图上
        timer = Timer(timeInterval: 1, repeats: true) { _ in
            seconds += 1
            
            self.formattedTime = FormatDisplay.time(seconds)
            //drop字符串最后三位，print可以发现这三位的内容是：" mi",mi表示的是英里，因为虚拟机的本地化缘故，所以单位是英里，drop三个字符后才能转型float
            self.formattedDistance = String(format: "%.2f", Float(FormatDisplay.distance(vm.distance.value).dropLast(3))!)
            //转型后才可以计算速度
            self.formattedSpeed = FormatDisplay.speed(distance: vm.distance, seconds: seconds, outputUnit: UnitSpeed.minutesPerKilometer)
        }
    
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}


extension RunningView{
    //MARK: - 状态机
    //枚举类型，创建状态
    enum Run_State:Int {
        case Preparing = 1
        case Running = 2
        case Pause = 3
        case Ending = 4
    }

    func changeState(newState: Run_State) {
        self.currentState = newState
        switch(newState){
        //初始化，准备状态 动画加载
        case .Preparing:
            break
        //跑步状态
        case .Running:
            //开始计时
            startTimer()
            //开始更新定位
            vm.requestLocation()
            break
        //暂停
        case .Pause:
            vm.stopUpdateLocation()
            stopTimer()
            break
        //结束状态,退出
        case .Ending:
            dismiss()
            break
        }
    }
    
}



struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
