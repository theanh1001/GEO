import Foundation

class Location: Identifiable {      // <- phải có : Identifiable
    let id = UUID()                 // <- phải có dòng này
    var name: String
    var latitude: Double
    var longitude: Double
    var icon: String

    init(name: String, latitude: Double, longitude: Double, icon: String) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.icon = icon
        print("Location initialized: \(name)")
    }

    deinit {
        print("Location deinitialized: \(name)")
    }
}
