import SwiftUI

struct ContentView: View {
    // State variables
    @State private var inputN = ""
    @State private var result = ""

    var body: some View {
        VStack(spacing: 20) {
            // Tiêu đề
            Text("Number Calculator")
                .font(.largeTitle)
                .bold()

            // TextField nhập số n
            TextField("Enter a number", text: $inputN)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)

            // Nút Calculate n²  (n * n)
            Button("Calculate n²") {
                calculate { n in n * n }
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)

            // Nút Calculate n³  (n * n * n)
            Button("Calculate n³") {
                calculate { n in n * n * n }
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)

            // Nút Double n  (n * 2)
            Button("Double n") {
                calculate { n in n * 2 }
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)

            // Hiển thị kết quả
            Text("Result: \(result)")
                .font(.title3)
        }
        .padding()
    }

    // Hàm dùng chung: kiểm tra input 1 lần, rồi tính theo phép tính được truyền vào
    func calculate(_ operation: (Int) -> Int) {
        if let n = Int(inputN) {
            let value = operation(n)
            result = "\(value)"
        } else {
            result = "Please enter a valid number."
        }
    }
}

#Preview {
    ContentView()
}
