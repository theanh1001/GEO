import Foundation
import MapKit

struct MapService {
    // Tính khoảng cách (km) và thời gian (phút) giữa 2 toạ độ bằng MKDirections
    static func getRoute(from source: CLLocationCoordinate2D,
                         to destination: CLLocationCoordinate2D,
                         completion: @escaping (Double, TimeInterval) -> Void) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                let distanceKm = route.distance / 1000          // mét -> km
                let timeMinutes = route.expectedTravelTime / 60 // giây -> phút
                completion(distanceKm, timeMinutes)
            } else {
                completion(0, 0)
            }
        }
    }
}
