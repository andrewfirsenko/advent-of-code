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
        var numbers: [Int] = line
            .split(separator: " ")
            .map {
                guard let number = Int(String($0)) else { fatalError("Parse Input") }
                return number
            }
        
        switch check(numbers: numbers) {
        case .success:
            result += 1
        case .failure(let index):
            var left = numbers
            left.remove(at: max(0, index - 1))
            var mid = numbers
            mid.remove(at: index)
            var right = numbers
            right.remove(at: min(numbers.count - 1, index + 1))
            
            switch (check(numbers: left), check(numbers: mid), check(numbers: right)) {
            case (.success, _, _): result += 1
            case (_, .success, _): result += 1
            case (_, _, .success): result += 1
            default: break
            }
        }
    }

    print("answer:", result)
}

private enum CheckResult {
    case success
    case failure(index: Int)
}

private func check(numbers: [Int]) -> CheckResult {
    let direction: Int = numbers[0] - numbers[1]
    for i in 0..<(numbers.count - 1) {
        let value: Int = numbers[i] - numbers[i + 1]
        guard (value < 0 && direction < 0) || (value > 0 && direction > 0) else {
            return .failure(index: i)
        }
        
        if abs(value) > 3 {
            return .failure(index: i)
        }
    }
    return .success
}

main()
