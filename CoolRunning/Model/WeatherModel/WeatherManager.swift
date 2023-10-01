
import Foundation
import Alamofire

protocol WeatherManagerDelegate: AnyObject {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: Weather)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    private var weatherURL = "https://devapi.qweather.com/v7/weather/now?key=29506e9647fe4aecb1839bb558ca1fbf"
    
    weak var delegate: WeatherManagerDelegate?
    /// 查询天气信息
    func fetchWeather(long: Double, lat: Double) {
        let longitude = String(format: "%.2f", long)
        let latitude = String(format: "%.2f", lat)
        let urlString = "\(weatherURL)&location=\(longitude),\(latitude)"
        inquireWeather(with: urlString)
    }

    func inquireWeather(with urlString: String) {
        AF.request(urlString).responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case let .success(data):
                let icon = data.now.icon
                let temp = data.now.temp
                let text = data.now.text
                let weather = Weather(icon: icon, temp: temp, text: text)
                delegate?.didUpdateWeather(self, weather: weather)
            case let .failure(error):
                delegate?.didFailWithError(error: error)
            }
        }
    }
}
