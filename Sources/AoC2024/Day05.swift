/// https://adventofcode.com/2024/day/5
package struct Day05 {
    let rules: [Int: Set<Int>]
    let updates: [Substring]

    package init(_ input: String) {
        let splitInput = input.split(separator: "\n\n")
        var rules: [Int: Set<Int>] = [:]
        splitInput[0].split(whereSeparator: \.isNewline).forEach { rule in
            let numbers = rule.split(separator: "|")
            guard let left = Int(String(numbers[0])),
                  let right = Int(String(numbers[1])) else {
                return
            }
            rules[left, default: Set<Int>()].insert(right)
        }
        self.rules = rules
        updates = splitInput[1].split(whereSeparator: \.isNewline)
    }

    package func part1() -> Int {
        var result: Int = 0
        updates.forEach { line in
            let reversedNumbers: [Int] = line.split(separator: ",").compactMap { Int(String($0)) }.reversed()
            var isCorrectLine: Bool = true
            for i in 0..<reversedNumbers.count {
                guard let rule = rules[reversedNumbers[i]] else { continue }
                for j in i..<reversedNumbers.count {
                    if rule.contains(reversedNumbers[j]) {
                        isCorrectLine = false
                        return
                    }
                }
                if !isCorrectLine {
                    break
                }
            }
            if isCorrectLine {
                result += reversedNumbers[reversedNumbers.count / 2]
            }
        }
        return result
    }

    package func part2() -> Int {
        var result: Int = 0
        updates.forEach { line in
            var reversedNumbers: [Int] = line.split(separator: ",").compactMap { Int(String($0)) }.reversed()
            var wasChanged: Bool = false
            var i: Int = 0
            while i < reversedNumbers.count {
                guard let rule = rules[reversedNumbers[i]] else {
                    i += 1
                    continue
                }
                for j in i..<reversedNumbers.count {
                    if rule.contains(reversedNumbers[j]) {
                        reversedNumbers.swapAt(i, j)
                        wasChanged = true
                        i -= 1
                        break
                    }
                }
                i += 1
            }
            if wasChanged {
                result += reversedNumbers[reversedNumbers.count / 2]
            }
        }
        return result
    }
}
