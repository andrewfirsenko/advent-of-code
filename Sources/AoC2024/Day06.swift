/// https://adventofcode.com/2024/day/6
package struct Day06 {
    let input: String

    package init(_ input: String) {
        self.input = input
    }

    package func part1() -> Int {
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
        return result
    }

    package func part2() -> Int {
        var x: Int = 0
        var y: Int = 0
        var direction: Direction = .up
        let map: [[Point]] = input
            .split(separator: "\n")
            .enumerated()
            .map { i, line in
                line.enumerated().map { j, ch in
                    if ch == "^" {
                        x = j
                        y = i
                    }
                    return Point(value: ch)
                }
            }
        let width: Int = map[0].count
        let height: Int = map.count

        var answer: Int = 0
        while let next = nextPoint(point: (x, y), direction: direction, width: width, height: height) {
            map[y][x].directions.insert(direction)
            if map[next.y][next.x].value == "#" {
                direction = nextDirection(for: direction)
                continue
            }
            // Тут можем двигаться дальше
            let checkDirection = nextDirection(for: direction)
            var checkX = x
            var checkY = y
            while let check = nextPoint(point: (checkX, checkY), direction: checkDirection, width: width, height: height),
                  map[check.y][check.x].value != "#" {
                if map[check.y][check.x].directions.contains(checkDirection) {
                    answer += 1
                    break
                }
                checkX = check.x
                checkY = check.y
            }
            y = next.y
            x = next.x
        }
        return answer
    }
}

private enum Direction {
    case up
    case down
    case left
    case right
}

private final class Point {
    let value: Character
    var directions: Set<Direction>

    init(value: Character) {
        self.value = value
        self.directions = Set()
    }
}

private func nextPoint(for point: (x: Int, y: Int), direction: Direction) -> (x: Int, y: Int) {
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

private func nextPoint(point: (x: Int, y: Int), direction: Direction, width: Int, height: Int) -> (x: Int, y: Int)? {
    let next = nextPoint(for: point, direction: direction)
    if next.x < 0 || next.x >= width || next.y < 0 || next.y >= height {
        return nil
    } else {
        return next
    }
}

private func nextDirection(for direction: Direction) -> Direction {
    switch direction {
    case .up: return .right
    case .down: return .left
    case .left: return .up
    case .right: return .down
    }
}

private func isCorrectPoint(point: (x: Int, y: Int), width: Int, height: Int) -> Bool {
    return point.x >= 0 && point.x < width && point.y >= 0 && point.y < height
}
