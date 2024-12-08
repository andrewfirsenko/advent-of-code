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
    
    // Horizontal
    for y in 0..<N {
        var line: String = ""
        for x in 0..<N {
            line += String(map[y][x])
        }
        result += countMatches(in: line)
    }
    
    // Vertical
    for x in 0..<N {
        var line: String = ""
        for y in 0..<N {
            line += String(map[y][x])
        }
        result += countMatches(in: line)
    }
    
    // Side diagonal
    var x: Int = 0
    var y: Int = 0
    repeat {
        var line: String = String(map[y][x])
        while y > 0 && x < N - 1 {
            y -= 1
            x += 1
            line += String(map[y][x])
        }
        result += countMatches(in: line)
        
        swap(&x, &y)
        if y < N - 1 {
            y += 1
        } else {
            x += 1
        }
    } while x < N
    
    // Main diagonal
    x = N - 1
    y = 0
    repeat {
        var line: String = String(map[y][x])
        while y < N - 1 && x < N - 1 {
            y += 1
            x += 1
            line += String(map[y][x])
        }
        result += countMatches(in: line)
        
        let newY = max(0, y - x + 1)
        let newX = max(0, x - y - 1)
        y = newY
        x = newX
    } while y < N
    
    print("answer:", result)
}

func countMatches(in text: String) -> Int {
    return text.matches(of: /XMAS/).count + text.matches(of: /SAMX/).count
}

main()
