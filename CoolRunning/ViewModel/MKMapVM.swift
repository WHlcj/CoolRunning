
import Foundation
import MapKit

/*
 TO DO:
 1. 获取步频信息
 */

//MARK: - 状态机
enum RunningState:Int {
    case Preparing = 1
    case Running = 2
    case Pause = 3
    case Ending = 4
}

class MKMapVM: NSObject, ObservableObject {
    // 存储用户位置
    @Published var locations: [CLLocationCoordinate2D] = []
    // 上一次位置信息
    private var pre_location: CLLocation?
    // 跑步信息
    @Published private(set) var distance = Measurement(value: 0, unit: UnitLength.meters)
    @Published private(set) var speed = 0.0
    // 步频(目前未实现功能)
    @Published private(set) var pace = 0
    private var timer: Timer?
    // 跑步时间
    @Published private(set) var seconds = 0.0
    // 当前跑步状态
    @Published var currentState = RunningState.Preparing
    
    // 地图和定位管理器
    var mapView = MapView()
    // 跑步Manager
    private var locationManager = CLLocationManager()
    /// 开始计时
    func startTimer() {
        timer = Timer(timeInterval: 1, repeats: true) { _ in
            self.seconds += 1
        }
        RunLoop.current.add(timer!, forMode: .default)
    }
    /// 停止时间
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    override init() {
        super.init()
        // 设置MKMapView的代理为自身
        mapView.map.delegate = self
        // 设置定位管理器的代理为自身
        locationManager.delegate = self
        // 请求用户授权
        locationManager.requestWhenInUseAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        //自动暂停定位更新
        locationManager.pausesLocationUpdatesAutomatically = false
        //活动模式 健身
        locationManager.activityType = .fitness
        //定位精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 开始更新用户位置
        locationManager.startUpdatingLocation()
        // 启动设备方向更新（可显示指针）
        locationManager.startUpdatingHeading()
    }
    
    func startRunning() {
        // 开始计时
        self.startTimer()
        // 修改运动状态
        self.currentState = .Running
    }
    
    func stopRunning() {
        // 停止计时
        self.stopTimer()
        // 修改运动状态
        if self.currentState == .Running {
            self.currentState = .Pause
        } else if self.currentState == .Pause {
            self.currentState = .Ending
            // 结束跑步,停止运动更新
            self.locationManager.stopUpdatingLocation()
        }
    }
    
}

// MARK: - CLLocationManagerDelegate
extension MKMapVM: CLLocationManagerDelegate {
    // CLLocationManagerDelegate 协议方法，当定位管理器更新位置时调用
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // 移动地图中心到用户位置
        let span = MKCoordinateSpan(latitudeDelta: 0.006, longitudeDelta: 0.006)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        self.mapView.map.setRegion(region, animated: true)
        
        // 防止数组过大，占用内存过大，引发崩溃
        if self.locations.count > 50 {
            self.locations = []
        }
        // 计算距离
        if self.currentState == .Running { // 必须是跑步状态才增加distance
            for newLocation in locations {
                let howRecent = newLocation.timestamp.timeIntervalSinceNow
                guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else{
                    continue }
                
                if let lastLocation = self.pre_location {
                    let delta = newLocation.distance(from: lastLocation)
                    self.distance = self.distance + Measurement(value: delta, unit: UnitLength.meters)
                }
                self.pre_location = newLocation
            }
        } else {
            self.locations = []
            self.pre_location = nil
        }
        
        if currentState != .Preparing {
            //print("manager的的current的值为：\(self.currentState)current地址为：\(withUnsafePointer(to: self.currentState) { $0 })")
            // 记录用户位置并绘制路径
            self.locations.append(location.coordinate)
            let polyline = MKPolyline(coordinates: self.locations, count: self.locations.count)
            self.mapView.map.addOverlay(polyline)
        }
    }
}

// MARK: - MKMapViewDelegate
extension MKMapVM: MKMapViewDelegate {
    // MKMapViewDelegate 协议方法，当地图需要渲染覆盖层时调用
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            // 渲染路径覆盖层
            let renderer = MKPolylineRenderer(polyline: polyline)
            switch currentState {
            case .Running:
                renderer.strokeColor = .systemGreen
            case .Pause:
                renderer.strokeColor = .systemGray
            default:
                break
            }
            renderer.lineWidth = 8
            //print("mapView的current的值为：\(self.currentState)mapView的current地址为：\(withUnsafePointer(to: self.currentState) { $0 })")
            //print("路径颜色为: \(renderer.strokeColor!.accessibilityName)")
            return renderer
        }
        // 如果不是路径覆盖层则返回默认的渲染器
        return MKOverlayRenderer()
    }
}
