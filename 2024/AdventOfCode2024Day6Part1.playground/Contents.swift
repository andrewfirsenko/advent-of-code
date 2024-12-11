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
    
    var map: [[Character]] = input
        .split(separator: "\n")
        .map { line in
            return line.map { $0 }
        }
    
    let width: Int = map[0].count
    let height: Int = map.count
    var startX: Int?
    let startY: Int? = map.firstIndex { line in
        if let x = line.firstIndex(of: "^") {
            startX = x
            return true
        } else {
            return false
        }
    }
    guard let startX, let startY else {
        fatalError("Couldn`t find start position")
    }
    
    var direction: Direction = .up
    var x: Int = startX
    var y: Int = startY
    while isCorrectPoint(point: (x, y), width: width, height: height) {
        map[y][x] = "X"
        
        let ifPoint = nextPoint(for: (x, y), direction: direction)
        if isCorrectPoint(point: ifPoint, width: width, height: height),
           map[ifPoint.y][ifPoint.x] == "#" {
            direction = nextDirection(for: direction)
            continue
        }
        
        x = ifPoint.x
        y = ifPoint.y
    }
    
    var result: Int = 0
    map.forEach { line in
        result += line.count { $0 == "X" }
    }
    print("answer:", result)
}

enum Direction {
    case up
    case down
    case left
    case right
}

func nextPoint(for point: (x: Int, y: Int), direction: Direction) -> (x: Int, y: Int) {
    switch direction {
    case .up:
        return (point.x, point.y - 1)
    case .down:
        return (point.x, point.y + 1)
    case .left:
        return (point.x - 1, point.y)
    case .right:
        return (point.x + 1, point.y)
    }
}

func nextDirection(for direction: Direction) -> Direction {
    switch direction {
    case .up: return .right
    case .down: return .left
    case .left: return .up
    case .right: return .down
    }
}

func isCorrectPoint(point: (x: Int, y: Int), width: Int, height: Int) -> Bool {
    return point.x >= 0 && point.x < width && point.y >= 0 && point.y < height
}

main()
