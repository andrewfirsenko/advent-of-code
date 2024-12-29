import Foundation

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Main

func main() {
    guard let input = loadFile(name: "Input") else {
        fatalError("Couldn`t load the file")
    }
    
    var result: Int = 0
    var lines = input.split { $0.isNewline }
    lines.forEach { line in
        guard let splitIndex = line.firstIndex(of: ":"),
              let sumNumber: Int = Int(String(line[line.startIndex..<splitIndex])) else {
            return
        }
        
        let numbers: [Int] = line[splitIndex..<line.endIndex]
            .split(separator: " ")
            .compactMap { Int(String($0)) }
            .reversed()
        
        if !numbers.isEmpty,
           determine(result: numbers.last!, reversedNumbers: numbers.dropLast(), condition: sumNumber) {
            result += sumNumber
        }
    }
    
    print("answer:", result)
}

func determine(result: Int, reversedNumbers: [Int], condition: Int) -> Bool {
    if result == condition { return true }
    if result > condition || reversedNumbers.isEmpty { return false }
    
    let nextNumber: Int = reversedNumbers.last!
    let newReversedNumbers: [Int] = reversedNumbers.dropLast()
    
    return determine(result: result + nextNumber, reversedNumbers: newReversedNumbers, condition: condition) ||
    determine(result: result * nextNumber, reversedNumbers: newReversedNumbers, condition: condition)
}

main()
