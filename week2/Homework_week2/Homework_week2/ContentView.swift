import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var orders: [Order] = SampleData.orders
    @State private var statusFilter = "Tất cả"

    let statuses = ["Tất cả", "Chưa giao", "Đang giao", "Đã giao"]

    // Lọc theo trạng thái
    var filteredOrders: [Order] {
        if statusFilter == "Tất cả" { return orders }
        return orders.filter { $0.status == statusFilter }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                // Lọc đơn hàng theo trạng thái
                Picker("Trạng thái", selection: $statusFilter) {
                    ForEach(statuses, id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)

                // Danh sách đơn - bấm vào để xem chi tiết + bản đồ
                List(filteredOrders) { order in
                    NavigationLink {
                        OrderDetailView(order: order)
                    } label: {
                        OrderRow(order: order)
                    }
                }

                // Thêm đơn hàng mới
                NavigationLink {
                    AddOrderView { newOrder in
                        orders.append(newOrder)
                    }
                } label: {
                    Label("Thêm đơn hàng", systemImage: "plus")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)

                Text("Tổng số đơn hàng: \(orders.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Đơn Hàng Cần Giao")
        }
    }
}

// Một dòng đơn hàng
struct OrderRow: View {
    let order: Order

    var distanceText: String {
        let a = CLLocation(latitude: order.restaurant.latitude, longitude: order.restaurant.longitude)
        let b = CLLocation(latitude: order.latitude, longitude: order.longitude)
        return String(format: "%.1f km", a.distance(from: b) / 1000)
    }

    var body: some View {
        HStack {
            Image(systemName: order.restaurant.icon)
                .font(.title2)
                .foregroundStyle(.orange)
                .frame(width: 36)

            VStack(alignment: .leading, spacing: 4) {
                Text(order.restaurant.name).font(.headline)
                Text("Giao cho: \(order.customerName)").font(.subheadline)
                Text(order.deliveryAddress)
                    .font(.caption).foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 6) {
                Text(distanceText).font(.subheadline).bold()
                StatusBadge(status: order.status)
            }
        }
        .padding(.vertical, 4)
    }
}

// Nhãn trạng thái có màu
struct StatusBadge: View {
    let status: String

    var color: Color {
        switch status {
        case "Đã giao":  return .green
        case "Đang giao": return .orange
        default:          return .gray
        }
    }

    var body: some View {
        Text(status)
            .font(.caption2).bold()
            .padding(.horizontal, 8).padding(.vertical, 4)
            .background(color.opacity(0.2))
            .foregroundStyle(color)
            .clipShape(Capsule())
    }
}

#Preview {
    ContentView()
}
