/// https://adventofcode.com/2023/day/5
package struct Day05 {
    let lines: [Substring]

    package init(_ input: String) {
        lines = input.split { $0.isNewline }
    }

    package func part1() -> Int {
        guard let initialLine = lines.first else { return 0 }
        var numbers: [Int] = []
        initialLine.split(separator: " ").forEach { string in
            guard let number = Int(string) else { return }
            numbers.append(number)
        }

        var maps: [Map] = []
        for i in 1..<lines.count {
            let line = String(lines[i])
            if line.contains("map:") {
                // Start new map
                maps.append(Map())
            } else {
                // Continue fill map
                let numbers = line.split(separator: " ").map { Int($0)! }
                let element = MapElement(
                    from: numbers[1],
                    to: numbers[1] + numbers[2],
                    offset: numbers[0] - numbers[1]
                )
                maps.last?.elements.append(element)
            }
        }

        for i in 0..<numbers.count {
            maps.forEach { map in
                var newNumber = numbers[i]
                map.elements.forEach { mapElement in
                    if numbers[i] >= mapElement.from && numbers[i] < mapElement.to {
                        newNumber = numbers[i] + mapElement.offset
                    }
                }
                numbers[i] = newNumber
            }
        }

        return numbers.min()!
    }

    /// Не решено: IOS-510 (интервалы).
    package func part2() -> Int {
        0
    }
}

private struct MapElement {
    let from: Int
    let to: Int
    let offset: Int
}

private final class Map {
    var elements: [MapElement] = []
}
