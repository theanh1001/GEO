import SwiftUI

struct ContentView: View {
    @State private var number1 = ""
    @State private var number2 = ""
    @State private var result = ""
    @State private var selectedFunction = 0

    let functions = [
        "Square (n²)",
        "Cube (n³)",
        "Factorial (n!)",
        "GCD / UCLN",
        "LCM / BCNN",
        "Check Prime"
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section("Number Tools") {
                    Picker("Function", selection: $selectedFunction) {
                        ForEach(0..<functions.count, id: \.self) { index in
                            Text(functions[index])
                                .tag(index)
                        }
                    }

                    TextField("Enter number", text: $number1)
                        .keyboardType(.numberPad)

                    if selectedFunction == 3 || selectedFunction == 4 {
                        TextField("Enter second number", text: $number2)
                            .keyboardType(.numberPad)
                    }

                    Button {
                        calculate()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Calculate")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }

                Section("Result") {
                    if result.isEmpty {
                        Text("Your result will appear here")
                            .foregroundStyle(.secondary)
                    } else {
                        Text(result)
                            .font(.title3)
                            .fontWeight(.semibold)
                    }
                }
            }
            .navigationTitle("Number Tools")
        }
    }

    // MARK: - Main Calculation

    func calculate() {
        guard let n = Int(number1) else {
            result = "❌ Please enter a valid integer."
            return
        }

        switch selectedFunction {

        // n²
        case 0:
            result = "\(n)² = \(n * n)"

        // n³
        case 1:
            result = "\(n)³ = \(n * n * n)"

        // n!
        case 2:
            if n < 0 {
                result = "❌ Factorial is only defined for n ≥ 0."
            } else if n > 20 {
                result = "❌ Please enter a number ≤ 20."
            } else {
                result = "\(n)! = \(factorial(n))"
            }

        // GCD
        case 3:
            guard let m = Int(number2) else {
                result = "❌ Please enter a valid second integer."
                return
            }

            result = "GCD(\(n), \(m)) = \(gcd(n, m))"

        // LCM
        case 4:
            guard let m = Int(number2) else {
                result = "❌ Please enter a valid second integer."
                return
            }

            if n == 0 || m == 0 {
                result = "LCM(\(n), \(m)) = 0"
            } else {
                result = "LCM(\(n), \(m)) = \(lcm(n, m))"
            }

        // Prime
        case 5:
            if isPrime(n) {
                result = "\(n) is a PRIME number ✅"
            } else {
                result = "\(n) is NOT a prime number ❌"
            }

        default:
            result = "❌ Invalid function."
        }
    }

    // MARK: - Factorial

    func factorial(_ n: Int) -> Int {
        if n == 0 || n == 1 {
            return 1
        }

        var answer = 1

        for i in 2...n {
            answer *= i
        }

        return answer
    }

    // MARK: - GCD / UCLN

    func gcd(_ a: Int, _ b: Int) -> Int {
        var x = abs(a)
        var y = abs(b)

        while y != 0 {
            let remainder = x % y
            x = y
            y = remainder
        }

        return x
    }

    // MARK: - LCM / BCNN

    func lcm(_ a: Int, _ b: Int) -> Int {
        return abs(a * b) / gcd(a, b)
    }

    // MARK: - Prime Number

    func isPrime(_ n: Int) -> Bool {
        if n < 2 {
            return false
        }

        if n == 2 {
            return true
        }

        if n % 2 == 0 {
            return false
        }

        var i = 3

        while i * i <= n {
            if n % i == 0 {
                return false
            }

            i += 2
        }

        return true
    }
}

#Preview {
    ContentView()
}
