
import Foundation
import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 39.916527, longitude: 116.397128)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?
    
    @Published var distance = Measurement(value: 0, unit: UnitLength.kilometers)
    @Published var locationList: [CLLocation] = []
    
    // 地图定位
    @Published var region =  MKCoordinateRegion(
        center: MapDetails.startingLocation,
        span: MapDetails.defaultSpan)
    
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
