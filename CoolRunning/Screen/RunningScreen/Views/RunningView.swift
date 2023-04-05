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
            VStack {
                runningInfo
                Spacer()
                runningButton
            }
        }
    }
    
    var runningInfo: some View {
        HStack(spacing: 12) {
            infoCell(info: FormatDisplay.distance(vm.distance), title: "路程")
            Divider()
            infoCell(info: FormatDisplay.time(vm.seconds), title: "时间")
            Divider()
            infoCell(info: FormatDisplay.speed(distance: vm.distance, seconds: vm.seconds), title: "配速")
            Divider()
            infoCell(info: "121", title: "步频")
        }
        .frame(height: 50)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            Color.white
        )
    }
    
    func infoCell(info: String, title: String) -> some View {
        VStack {
            Text(info)
                .font(.title2.bold())
            Text(title)
                .font(.body)
        }
        .foregroundColor(.black)
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

struct RunningView_Previews: PreviewProvider {
    static var previews: some View {
        RunningView()
    }
}
