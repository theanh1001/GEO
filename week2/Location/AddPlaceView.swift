import SwiftUI

struct AddPlaceView: View {
    // Closure gọi ngược về ContentView để gửi địa điểm mới
    let onSave: (Location) -> Void

    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var latitude = ""
    @State private var longitude = ""

    var body: some View {
        Form {
            Section(header: Text("Place Information")) {
                TextField("Name", text: $name)
                TextField("Latitude", text: $latitude)
                    .keyboardType(.decimalPad)
                TextField("Longitude", text: $longitude)
                    .keyboardType(.decimalPad)
            }
        }
        .navigationTitle("Add Place")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    // kiểm tra dữ liệu hợp lệ rồi mới lưu
                    if let lat = Double(latitude),
                       let lon = Double(longitude),
                       !name.isEmpty {
                        let newPlace = Location(
                            name: name,
                            latitude: lat,
                            longitude: lon,
                            icon: "mappin.circle.fill"   // icon mặc định cho địa điểm mới
                        )
                        onSave(newPlace)   // gửi về ContentView
                        dismiss()          // quay lại màn hình chính
                    }
                }
            }
        }
    }
}
