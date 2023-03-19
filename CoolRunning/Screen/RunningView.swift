//
//  RunningView.swift
//  CoolRunning
//
//  Created by 何纪栋 on 2023/3/18.
//

import SwiftUI
import CoreLocation

struct RunningView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var locationManager = LocationManager()
    
    @State private var timer: Timer?
    @State private var seconds = 0
    
    @State private var formattedSpeed = String()
    @State private var formattedDistance = String()
    @State private var formattedTime = String()
    
    @State var currentState = Run_State.Running
    
    
    var body: some View {
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
            locationManager.requestLocation()
        }
    }
    
    func startTimer() {
        //计时器创建
        timer = Timer(timeInterval: 1, repeats: true) { _ in
            seconds += 1
            //格式化后的数据伴随着计时器的更新一同更新在视图上
            //formatted类我已写好放在Extension文件夹下
            //数据格式当初折磨了我很久，因此代码显得没那么优雅，但是能跑哈哈，你可以是的自己修改
            self.formattedTime = FormatDisplay.time(seconds)
            //drop字符串最后三位，print可以发现这三位的内容是：" mi",mi表示的是英里，因为虚拟机的本地化缘故，所以单位是英里，drop三个字符后才能转型float
            self.formattedDistance = String(format: "%.2f", Float(FormatDisplay.distance(locationManager.distance.value).dropLast(3))!)
            //转型后才可以计算速度
            self.formattedSpeed = FormatDisplay.speed(distance: locationManager.distance, seconds: seconds, outputUnit: UnitSpeed.minutesPerKilometer)
        }
    
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
}
//MARK: - 状态机
//用状态机来管理运动状态，因为可能会涉及到准备状态，我这里预留，准备态一般是keep等运动app在进入运动页后的三秒倒计时状态
extension RunningView{
    //枚举类型，创建状态
    enum Run_State:Int {
        case Preparing = 1
        case Running = 2
        case Pause = 3
        case Ending = 4
    }
    //switch/case方法实现状态机
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
            locationManager.requestLocation()
            break
        //暂停
        case .Pause:
            locationManager.stopUpdateLocation()
            stopTimer()
            break
        //结束状态,退出
        case .Ending:
            presentationMode.wrappedValue.dismiss()
            break
        }
    }
    
}

///请求定位权限需要在info.pilst内添加Privacy - Location Always and When In Use Usage Description等
///在target内的info处添加，我已添加好
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?
    
    @Published var distance = Measurement(value: 0, unit: UnitLength.kilometers)
    @Published var locationList: [CLLocation] = []
        
    override init(){
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        //活动模式 健身
        locationManager.activityType = .fitness
        //定位精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //开始定位
        locationManager.startUpdatingLocation()
        //自动暂停定位更新
        locationManager.pausesLocationUpdatesAutomatically = false
        //后台更新
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
       }
    
    func stopUpdateLocation(){
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else{
                continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
                _ = [lastLocation.coordinate, newLocation.coordinate]
            }
            locationList.append(newLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失败")
    }
}

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
