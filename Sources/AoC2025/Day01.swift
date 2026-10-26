/// https://adventofcode.com/2025/day/1
package struct Day01 {
    let lines: [Substring]

    package init(_ input: String) {
        lines = input.split { $0.isNewline }
    }

    package func part1() -> Int {
        let maxCount: Int = 100
        var point: Int = 50
        var password: Int = 0

        lines.forEach { line in
            guard let direction = line.first,
                  let number = Int(line.dropFirst()) else {
                return
            }

            if direction == "L" {
                point = point - (number % maxCount)
                if point < 0 {
                    point = maxCount + point
                }
            }

            if direction == "R" {
                point = (point + number) % maxCount
            }

            if point == 0 {
                password += 1
            }
        }
        return password
    }

    package func part2() -> Int {
        let maxCount: Int = 100
        var point: Int = 50
        var password: Int = 0

        lines.forEach { line in
            guard let direction = line.first,
                  var number = Int(line.dropFirst()) else {
                return
            }

            // full circle
            password += number / maxCount
            number = number % maxCount

            if direction == "L" {
                let toPoint = (point + maxCount - number) % maxCount
                if toPoint == 0 || (toPoint > point && point != 0) {
                    password += 1
                }
                point = toPoint
            }

            if direction == "R" {
                let toPoint = (point + number) % maxCount
                if toPoint < point {
                    password += 1
                }
                point = toPoint
            }
        }
        return password
    }
}
