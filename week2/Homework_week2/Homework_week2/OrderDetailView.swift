import SwiftUI
import MapKit

struct OrderDetailView: View {
    @Bindable var order: Order      // @Bindable để đổi trạng thái được

    @State private var distance: Double = 0
    @State private var time: Double = 0
    @State private var cameraPosition: MapCameraPosition = .automatic

    var body: some View {
        VStack(spacing: 0) {
            // Bản đồ: ghim quán (đỏ) + địa chỉ giao (xanh)
            Map(position: $cameraPosition) {
                Marker(order.restaurant.name, coordinate: order.restaurant.coordinate)
                    .tint(.red)
                Marker("Địa chỉ giao", coordinate: order.deliveryCoordinate)
                    .tint(.blue)
            }
            .frame(height: 320)

            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Image(systemName: order.restaurant.icon).foregroundStyle(.orange)
                    VStack(alignment: .leading) {
                        Text(order.restaurant.name).font(.headline)
                        Text(order.restaurant.address)
                            .font(.caption).foregroundStyle(.secondary)
                    }
                }

                HStack {
                    Image(systemName: "house.fill").foregroundStyle(.blue)
                    VStack(alignment: .leading) {
                        Text("Giao cho: \(order.customerName)").font(.headline)
                        Text(order.deliveryAddress)
                            .font(.caption).foregroundStyle(.secondary)
                    }
                }

                HStack {
                    Image(systemName: "car.fill")
                    if distance > 0 {
                        Text(String(format: "Khoảng cách: %.1f km (≈ %.0f phút)", distance, time))
                    } else {
                        Text("Đang tính khoảng cách...").foregroundStyle(.secondary)
                    }
                }
                .font(.subheadline)

                // Cập nhật trạng thái đơn hàng
                Text("Trạng thái:").font(.subheadline).bold()
                Picker("Trạng thái", selection: $order.status) {
                    ForEach(["Chưa giao", "Đang giao", "Đã giao"], id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Chi tiết đơn hàng")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            MapService.getRoute(from: order.restaurant.coordinate,
                                to: order.deliveryCoordinate) { dist, t in
                distance = dist
                time = t
            }
        }
    }
}
