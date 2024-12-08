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
    
    let map: [[Character]] = input
        .split { $0.isNewline }
        .map { line in
            return line.map { $0 }
        }
    
    guard map.count == map.first?.count else { fatalError("Map is not square") }
    let N: Int = map.count
    var result: Int = 0
    
    for y in 1..<(N - 1) {
        for x in 1..<(N - 1) {
            guard map[y][x] == "A",
                  isMS(lhs: map[y - 1][x - 1], rhs: map[y + 1][x + 1]),
                  isMS(lhs: map[y + 1][x - 1], rhs: map[y - 1][x + 1]) else {
                continue
            }
            
            result += 1
        }
    }
    
    print("answer:", result)
}

func isMS(lhs: Character, rhs: Character) -> Bool {
    if (lhs == "M" && rhs == "S") || lhs == "S" && rhs == "M" {
        return true
    } else {
        return false
    }
}

main()
