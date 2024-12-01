import Foundation

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Main

func main() {
    guard let input = loadFile(name: "Input") else { fatalError("Couldn`t load the file") }
    
    var leftNumbers: [Int] = []
    var rightNumbers: [Int] = []
    let lines = input.split { $0.isNewline }
    lines.forEach { line in
        let params = line.split(separator: " ")
        guard let leftNumber: Int = Int(String(params[0])),
              let rightNumber: Int = Int(String(params[1])) else {
            fatalError("Parse Input")
        }
        leftNumbers.append(leftNumber)
        rightNumbers.append(rightNumber)
    }
    
    var result: Int = 0
    var dict: [Int: Int] = [:]
    rightNumbers.forEach { right in
        dict[right, default: 0] += 1
    }
    leftNumbers.forEach { left in
        if let value = dict[left] {
            result += left * value
        }
    }
    
    print("answer:", result)
}

main()

