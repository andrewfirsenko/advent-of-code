import Foundation

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Main

func main() {
    guard let input = loadFile(name: "Input") else { fatalError("Couldn`t load the file") }
    
    var result: Int = 0
    let lines = input.split { $0.isNewline }
    lines.forEach { line in
        let numbers: [Int] = line
            .split(separator: " ")
            .map {
                guard let number = Int(String($0)) else { fatalError("Parse Input") }
                return number
            }
        let direction: Int = numbers[1] - numbers[0]
        for i in 1..<numbers.count {
            let value: Int = numbers[i] - numbers[i - 1]
            guard (value < 0 && direction < 0) || (value > 0 && direction > 0) else {
                return
            }
            
            if abs(value) > 3 {
                return
            }
        }
        result += 1
    }

    print("answer:", result)
}

main()

