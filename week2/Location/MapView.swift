import SwiftUI
import MapKit

struct MapView: View {
    let place: Location   // địa điểm được truyền vào

    // Vùng hiển thị của bản đồ, canh giữa vào tọa độ của place
    @State private var cameraPosition: MapCameraPosition

    init(place: Location) {
        self.place = place
        // Khởi tạo vị trí camera dựa trên tọa độ địa điểm
        let coordinate = CLLocationCoordinate2D(
            latitude: place.latitude,
            longitude: place.longitude
        )
        _cameraPosition = State(initialValue: .region(
            MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        ))
    }

    var body: some View {
        Map(position: $cameraPosition) {
            // Đặt một ghim (marker) tại địa điểm
            Marker(place.name, coordinate: CLLocationCoordinate2D(
                latitude: place.latitude,
                longitude: place.longitude
            ))
            .tint(.red)
        }
        .navigationTitle(place.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
