/*
  北京: latitude:39.916527,longitude:116.397128
 */

import SwiftUI
import MapKit


struct RunningTestView: View {

    @StateObject var vm = WeatherVM()
    
    var body: some View {
        VStack {
            if vm.isLoaded {
                HStack {
                    Image(vm.icon)
                        .resizable()
                    VStack {
                        Text(vm.text)
                        Text(vm.temp)
                    }
                    .foregroundColor(.gray)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            vm.inquireWeather()
        }
    }
}

struct RunningTestView_Previews: PreviewProvider {
    static var previews: some View {
        RunningTestView()
            .frame(width: 200, height: 180)
    }
}
