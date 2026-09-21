import SwiftUI

struct ContentView: View {
    // @State private var để có thể THÊM địa điểm mới
    @State private var places: [Location] = [
        Location(name: "🎓️ HCMUTE 🎓️",      latitude: 10.8506, longitude: 106.7719, icon: "graduationcap.fill"),
        Location(name: "🏠 Home 🏠",        latitude: 10.9500, longitude: 106.8200, icon: "house.fill"),
        Location(name: "☕ Coffee Shop ☕", latitude: 10.8752, longitude: 106.8012, icon: "cup.and.saucer.fill"),
        Location(name: "*ੈ🎡‧₊˚Park*ੈ🎡‧₊˚",        latitude: 10.8601, longitude: 106.7930, icon: "tree.fill")
    ]

    @State private var searchText = ""

    // Vị trí ảnh có thể kéo
    @State private var position = CGSize.zero
    @State private var dragOffset = CGSize.zero

    // Danh sách đã LỌC theo ô search
    var filteredPlaces: [Location] {
        if searchText.isEmpty {
            return places
        } else {
            return places.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {

                // 1. Header: Icon + Title + Subtitle
                VStack(spacing: 8) {
                    Image(systemName: "mappin.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.red)
                    Text("Your Places")
                        .font(.largeTitle).bold()
                    Text("Save places you dont love!")
                        .foregroundColor(.gray)
                }

                // Ảnh của bạn - kéo để di chuyển
                Image("image1")               // tên ảnh trong Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .offset(
                        x: position.width + dragOffset.width,
                        y: position.height + dragOffset.height
                    )
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                dragOffset = value.translation
                            }
                            .onEnded { value in
                                position.width += value.translation.width
                                position.height += value.translation.height
                                dragOffset = .zero
                            }
                    )

                // 3. Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search place...", text: $searchText)
                }
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)

                // 4. List of places - bấm vào để mở bản đồ
                List(filteredPlaces) { place in
                    NavigationLink {
                        MapView(place: place)      // chuyển sang màn hình bản đồ
                    } label: {
                        HStack {
                            Image(systemName: place.icon)
                                .foregroundStyle(.blue)
                                .frame(width: 30)
                            VStack(alignment: .leading) {
                                Text(place.name)
                                    .font(.headline)
                                Text("\(place.latitude), \(place.longitude)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                // 5. Add Place button -> NavigationLink sang AddPlaceView
                NavigationLink {
                    AddPlaceView { newPlace in
                        places.append(newPlace)   // thêm vào danh sách
                    }
                } label: {
                    Label("Add Place", systemImage: "plus")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(.horizontal)

                // 6. Total count
                Text("Total places: \(places.count)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ContentView()
}
