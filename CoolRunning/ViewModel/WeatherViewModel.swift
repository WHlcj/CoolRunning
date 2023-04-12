
import Foundation
import CoreLocation
import QWeather
import Alamofire

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {

    @Published var icon: String = ""
    @Published var temp: String = ""
    @Published var text: String = ""
    @Published var isRequested = false
    @Published var isLoaded = false
    private var urlString = "https://devapi.qweather.com/v7/weather/now?location=101010100&key=29506e9647fe4aecb1839bb558ca1fbf"
    private var locationCode = ""
    
    private var locationManager = CLLocationManager()
    
    override init() {
        super .init()
        locationManager.delegate = self
        // 开启定位
        locationManager.requestWhenInUseAuthorization()
    }

    func inquireWeather() {
        locationManager.startUpdatingLocation()
        AF.request(self.urlString).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case let .success(data):
                self.icon = data.now.icon
                self.temp = data.now.temp + "℃"
                self.text = data.now.text
                self.isLoaded = true
            case let .failure(error):
                print(error)
                print("天气信息请求失败!")
            }
        }
        // 网络请求
        self.locationManager.stopUpdatingLocation()
        print("成功关闭locationManager")
        self.isRequested = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.locationCode = String(location.coordinate.longitude).dropLast(5)+","+String(location.coordinate.latitude).dropLast(5)
        self.urlString = "https://devapi.qweather.com/v7/weather/now?location="+locationCode+"&key=29506e9647fe4aecb1839bb558ca1fbf"
        print(urlString)
    }
    
    
    
}
