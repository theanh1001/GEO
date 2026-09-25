import Foundation
import CoreLocation
import Observation

@Observable
class Restaurant: Identifiable {
    let id = UUID()
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var icon: String            // icon theo loại quán

    init(name: String, address: String, latitude: Double, longitude: Double, icon: String = "fork.knife") {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.icon = icon
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

@Observable
class Order: Identifiable {
    let id = UUID()
    var restaurant: Restaurant
    var customerName: String
    var deliveryAddress: String
    var latitude: Double        // toạ độ giao hàng
    var longitude: Double
    var status: String          // "Chưa giao", "Đang giao", "Đã giao"

    init(restaurant: Restaurant, customerName: String, deliveryAddress: String,
         latitude: Double, longitude: Double, status: String = "Chưa giao") {
        self.restaurant = restaurant
        self.customerName = customerName
        self.deliveryAddress = deliveryAddress
        self.latitude = latitude
        self.longitude = longitude
        self.status = status
    }

    var deliveryCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
