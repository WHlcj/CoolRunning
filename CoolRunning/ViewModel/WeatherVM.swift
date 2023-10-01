
import Foundation
import CoreLocation
import QWeather
import Alamofire

class WeatherVM: NSObject, ObservableObject {

    @Published var icon: String = ""
    @Published var temp: String = ""
    @Published var depriction: String = ""
    // 防止多次查询
    @Published var isRequested = false
    // 获取天气信息后加载视图
    @Published var isLoaded = false
    // 用于获取经纬度信息
    private var locationManager = CLLocationManager()
    // 用于查询天气信息
    private var weatherManager = WeatherManager()
    
    override init() {
        super .init()
        weatherManager.delegate = self
        locationManager.delegate = self
        // 开启定位
        locationManager.requestWhenInUseAuthorization()
    }
}
// MARK: - CLLocationManagerDelegate
extension WeatherVM: CLLocationManagerDelegate {
    /// 查询天气信息
    func inquireWeather() {
        locationManager.requestLocation()
        self.isRequested = true
    }
    // 成功请求位置信息调用的函数
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // 查询当前定位的天气实时信息
        self.weatherManager.fetchWeather(long: location.coordinate.longitude, lat: location.coordinate.latitude)
    }
    // 失败请求位置信息
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

// MARK: - WeatherManagerDelegate
extension WeatherVM: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: Weather) {
        self.icon = weather.iconName
        self.temp = weather.tempString
        self.depriction = weather.text
        self.isLoaded = true
    }
    
    func didFailWithError(error: Error) {
        print(error)
        print("天气信息获取失败!")
    }
}
