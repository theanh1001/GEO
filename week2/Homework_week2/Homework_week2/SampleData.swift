import Foundation

enum SampleData {
    static var orders: [Order] {
        [
            Order(restaurant: Restaurant(name: "Phở 24", address: "10 Nguyễn Văn Linh, Q.7",
                    latitude: 10.7340, longitude: 106.7215, icon: "fork.knife"),
                  customerName: "Nguyễn Văn A", deliveryAddress: "123 Lê Văn Sỹ, Q.3",
                  latitude: 10.7900, longitude: 106.6700, status: "Chưa giao"),
            Order(restaurant: Restaurant(name: "Highlands Coffee", address: "72 Lê Lợi, Q.1",
                    latitude: 10.7730, longitude: 106.7010, icon: "cup.and.saucer.fill"),
                  customerName: "Trần Thị B", deliveryAddress: "456 Điện Biên Phủ, Q.10",
                  latitude: 10.7690, longitude: 106.6670, status: "Đang giao"),
            Order(restaurant: Restaurant(name: "Lotteria", address: "285 CMT8, Q.10",
                    latitude: 10.7750, longitude: 106.6690, icon: "takeoutbag.and.cup.and.straw.fill"),
                  customerName: "Lê Minh C", deliveryAddress: "789 Âu Cơ, Q.11",
                  latitude: 10.7660, longitude: 106.6420, status: "Chưa giao"),
            Order(restaurant: Restaurant(name: "Pizza Hut", address: "1 Võ Văn Ngân, Thủ Đức",
                    latitude: 10.8500, longitude: 106.7570, icon: "fork.knife.circle.fill"),
                  customerName: "Phạm Thị D", deliveryAddress: "12 Hoàng Diệu 2, Thủ Đức",
                  latitude: 10.8490, longitude: 106.7620, status: "Đã giao"),
            
            Order(restaurant: Restaurant(name: "Theanh", address: "1 theanh, TheAnh",
                    latitude: 10.8900, longitude: 106.98, icon: "sunglasses.fill"),
                  customerName: "theanhdeptrai", deliveryAddress: "2 theanh, TheAnh",
                  latitude: 10.84, longitude: 106.48, status: "Chưa giao")
        ]
    }
}
