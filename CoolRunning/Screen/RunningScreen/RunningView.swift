/*
  北京: latitude:39.916527,longitude:116.397128
 */

/*
 TO DO:
 1. UI美化工作
 */
import SwiftUI
import MapKit

struct RunningView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = MKMapViewModel()

    var body: some View {
        ZStack {
            MapView(mapView: vm.mapView)
                .ignoresSafeArea()
                .onAppear {
                    vm.startRunning()
                }
                .onDisappear {
                    vm.locationManager.stopUpdatingLocation()
                    vm.stopTimer()
                }
            VStack {
                Spacer()
                runningInfo
                runningButton
            }
        }
    }
    
    var runningInfo: some View {
        VStack {
            Text("Distance: " + FormatDisplay.distance(vm.distance) + "km")
            Text("Time:     " + FormatDisplay.time(vm.seconds))
            Text("平均配速:  " + FormatDisplay.speed(distance: vm.distance, seconds: vm.seconds))
        }
        .padding()
    }
    
    var runningButton: some View {
        VStack {
            switch vm.currentState {
            case .Running:
                Button("暂停") {
                    vm.stopRunning()
                }
            case .Pause:
                HStack {
                    Button("继续") {
                        vm.startRunning()
                    }
                    Button("结束") {
                        vm.stopRunning()
                        dismiss()
                    }
                }
            case .Preparing:
                Text("isPrepared")
            case .Ending:
                Text("isEnded")
            }
        }
    }
    
  
}

extension RunningView {

 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
