
import SwiftUI

struct WeatherInfoCell: View {
    // 创建天气查询的ViewModel
    @StateObject var vm = WeatherVM()
    var body: some View {
        VStack {
            // 加载成功
            if vm.isLoaded {
                HStack {
                    Image(vm.icon)
                        .resizable()
                    VStack {
                        Text(vm.depriction)
                        Text(vm.temp)
                    }
                    .foregroundColor(.gray)
                }
            // 暂未获取信息
            } else {
                ProgressView()
                    .scaleEffect(2)
                    .frame(width: 120, height: 80)
            }
        }
        .frame(maxWidth: 120, maxHeight: 90)
        .onAppear {
            // 防止多次请求
            if !vm.isRequested {
                vm.inquireWeather()
            }
        }
    }
}

struct WeatherInfoView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoCell()
            .frame(width: 200, height: 180)
    }
}
