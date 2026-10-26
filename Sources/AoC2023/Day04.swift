/// https://adventofcode.com/2023/day/4
package struct Day04 {
    let lines: [Substring]

    package init(_ input: String) {
        lines = input.split { $0.isNewline }
    }

    package func part1() -> Int {
        var sum = 0
        lines.forEach { line in
            let winConunt = winCount(line: line)
            // result
            if winConunt > 0 {
                let points = 1 << (winConunt - 1)
                sum += points
            }
        }
        return sum
    }

    package func part2() -> Int {
        var cards = [Int](repeating: 1, count: lines.count)
        lines.enumerated().forEach { (index, line) in
            let winConunt = winCount(line: line)
            for offset in 0..<winConunt {
                let offsetIndex = index + offset + 1
                guard offsetIndex < lines.count else { return }
                cards[offsetIndex] = cards[offsetIndex] + cards[index]
            }
        }
        return cards.reduce(0, +)
    }

    private func winCount(line: Substring) -> Int {
        // given
        var numbers: Set<Int> = []
        var winConunt: Int = 0
        let line: String = String(line)
        guard let startIndex = line.firstIndex(of: ":"),
              let middleIndex = line.firstIndex(of: "|") else { return 0 }
        let winLine = String(line[startIndex...middleIndex])
        let userLine = String(line[middleIndex...])

        // main
        winLine.split(separator: " ").forEach { number in
            guard let number = Int(number) else { return }
            numbers.insert(number)
        }
        userLine.split(separator: " ").forEach { number in
            guard let number = Int(number) else { return }
            if numbers.contains(number) {
                winConunt += 1
            }
        }
        return winConunt
    }
}
