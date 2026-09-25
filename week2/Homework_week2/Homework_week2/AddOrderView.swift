import SwiftUI

struct AddOrderView: View {
    let onSave: (Order) -> Void
    @Environment(\.dismiss) var dismiss

    @State private var restaurantName = ""
    @State private var restaurantAddress = ""
    @State private var restLat = ""
    @State private var restLon = ""
    @State private var customerName = ""
    @State private var deliveryAddress = ""
    @State private var delivLat = ""
    @State private var delivLon = ""

    var body: some View {
        Form {
            Section("Thông tin quán") {
                TextField("Tên quán", text: $restaurantName)
                TextField("Địa chỉ quán", text: $restaurantAddress)
                TextField("Vĩ độ quán", text: $restLat).keyboardType(.decimalPad)
                TextField("Kinh độ quán", text: $restLon).keyboardType(.decimalPad)
            }
            Section("Thông tin giao hàng") {
                TextField("Tên khách", text: $customerName)
                TextField("Địa chỉ giao", text: $deliveryAddress)
                TextField("Vĩ độ giao", text: $delivLat).keyboardType(.decimalPad)
                TextField("Kinh độ giao", text: $delivLon).keyboardType(.decimalPad)
            }
        }
        .navigationTitle("Thêm đơn hàng")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Huỷ") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Lưu") { save() }
            }
        }
    }

    func save() {
        guard let rLat = Double(restLat), let rLon = Double(restLon),
              let dLat = Double(delivLat), let dLon = Double(delivLon),
              !restaurantName.isEmpty, !customerName.isEmpty else { return }

        let restaurant = Restaurant(name: restaurantName, address: restaurantAddress,
                                    latitude: rLat, longitude: rLon)
        let order = Order(restaurant: restaurant, customerName: customerName,
                          deliveryAddress: deliveryAddress,
                          latitude: dLat, longitude: dLon)
        onSave(order)
        dismiss()
    }
}
