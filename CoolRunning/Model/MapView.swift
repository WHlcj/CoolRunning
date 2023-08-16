import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {

    var map = MKMapView()
    
    internal func makeUIView(context: Context) -> MKMapView {
        //map.delegate = context.coordinator // 将代理设置为 MKMapVM
        return map
    }
    
    // 在updateUIView方法中更新地图视图
    internal func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.showsUserLocation = true
        uiView.showsCompass = true
        uiView.showsScale = true
    }
    
}

