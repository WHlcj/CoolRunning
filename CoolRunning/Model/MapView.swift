import MapKit
import SwiftUI

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 39.916527, longitude: 116.397128)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.003, longitudeDelta: 0.003)
    static let defaultRegion = MKCoordinateRegion(
        center: MapDetails.startingLocation,
        span: MapDetails.defaultSpan)
}

struct MapView: UIViewRepresentable {

    var mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        let region = MapDetails.defaultRegion
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
        mapView.showsCompass = true
       // mapView.delegate = context.coordinator
        return mapView
    }
    
    // 在updateUIView方法中更新地图视图
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.showsUserLocation = true
    }
    
//    func makeCoordinator() -> MKMapViewModel {
//        MKMapViewModel()
//    }
}
