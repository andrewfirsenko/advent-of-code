/// https://adventofcode.com/2023/day/2
package struct Day02 {
    let input: String

    package init(_ input: String) {
        self.input = input
    }

    /// Решение части 1 не сохранилось.
    package func part1() -> Int {
        0
    }

    package func part2() -> Int {
        let lines = input.split { $0.isNewline }
        var sum = 0
        lines.enumerated().forEach { (index, line) in
            // given
            var line: String = String(line)
            guard let startIndex = line.firstIndex(of: ":") else { return }
            line = String(line[startIndex...])
            line.removeFirst(2) // remove ": "

            // main
            var maxCountForColor: [Color: Int] = [
                .red: 1,
                .green: 1,
                .blue: 1
            ]
            line.split(separator: ";").forEach { game in
                game.split(separator: ",").forEach { pair in
                    let pair = pair.split(separator: " ").map { String($0) }
                    guard let countString = pair.first, let colorString = pair.last else { return }
                    guard let count = Int(countString), let color = Color(rawValue: colorString) else { return }
                    guard let value = maxCountForColor[color] else { return }
                    if count > value {
                        maxCountForColor[color] = count
                    }
                }
            }
            var valueForSum = 1
            maxCountForColor.forEach { (_, value) in
                valueForSum *= value
            }
            sum += valueForSum
        }
        return sum
    }
}

private enum Color: String, RawRepresentable {
    case red
    case green
    case blue

    init?(rawValue: String) {
        switch rawValue {
        case "red": self = .red
        case "green": self = .green
        case "blue": self = .blue
        default: return nil
        }
    }

    var maxValue: Int {
        switch self {
        case .red: return 12
        case .green: return 13
        case .blue: return 14
        }
    }
}
