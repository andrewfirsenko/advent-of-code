import Foundation

/// https://adventofcode.com/2023/day/7
package struct Day07 {
    let lines: [Substring]

    package init(_ input: String) {
        lines = input.split { $0.isNewline }
    }

    package func part1() -> Int {
        var elements: [Element] = lines.map { tmp in
            let pair = tmp.split(separator: " ")
            let string = String(pair[0])
            return Element(
                combination: Part1.Combination(string: string)!.rawValue,
                hash: Part1.customHash(string),
                value: Int(pair[1])!
            )
        }
        return totalWinnings(&elements)
    }

    package func part2() -> Int {
        var elements: [Element] = lines.map { tmp in
            let pair = tmp.split(separator: " ")
            let string = String(pair[0])
            return Element(
                combination: Part2.Combination(string: string)!.rawValue,
                hash: Part2.customHash(string),
                value: Int(pair[1])!
            )
        }
        return totalWinnings(&elements)
    }

    private func totalWinnings(_ elements: inout [Element]) -> Int {
        elements.sort { lhs, rhs in
            if lhs.combination == rhs.combination {
                return lhs.hash < rhs.hash
            } else {
                return lhs.combination < rhs.combination
            }
        }
        var sum: Int = 0
        elements.enumerated().forEach { (index, element) in
            sum += element.value * (index + 1)
        }
        return sum
    }
}

private struct Element {
    let combination: Int
    let hash: Int
    let value: Int
}

private enum Part1 {
    enum Alphabet: Int {
        case A = 14
        case K = 13
        case Q = 12
        case J = 11
        case T = 10
        case c9 = 9
        case c8 = 8
        case c7 = 7
        case c6 = 6
        case c5 = 5
        case c4 = 4
        case c3 = 3
        case c2 = 2

        init?(char: Character) {
            switch char {
            case "A": self = .A
            case "K": self = .K
            case "Q": self = .Q
            case "J": self = .J
            case "T": self = .T
            case "9": self = .c9
            case "8": self = .c8
            case "7": self = .c7
            case "6": self = .c6
            case "5": self = .c5
            case "4": self = .c4
            case "3": self = .c3
            case "2": self = .c2
            default: return nil
            }
        }
    }

    static func customHash(_ string: String) -> Int {
        var sum: Int = 0
        string.reversed().enumerated().forEach { (index, element) in
            sum += Int(pow(100, Double(index))) * Alphabet(char: element)!.rawValue
        }
        return sum
    }

    enum Combination: Int {
        case five = 32
        case four = 17
        case fullHouse = 12
        case three = 10
        case twoPair = 9
        case onePair = 7
        case high = 5

        init?(string: String) {
            let dictionary = string.reduce(into: [Character: Int]()) { partialResult, ch in
                partialResult[ch, default: 0] += 1
            }
            let result = dictionary.values.reduce(0) { partialResult, value in
                if value <= 1 {
                    return partialResult + 1
                } else {
                    return partialResult + Int(pow(2, Double(value)))
                }
            }
            self.init(rawValue: result)
        }
    }
}

private enum Part2 {
    enum Alphabet: Int {
        case A  = 23
        case K  = 22
        case Q  = 21
        case T  = 20
        case c9 = 19
        case c8 = 18
        case c7 = 17
        case c6 = 16
        case c5 = 15
        case c4 = 14
        case c3 = 13
        case c2 = 12
        case J  = 11

        init?(char: Character) {
            switch char {
            case "A": self = .A
            case "K": self = .K
            case "Q": self = .Q
            case "J": self = .J
            case "T": self = .T
            case "9": self = .c9
            case "8": self = .c8
            case "7": self = .c7
            case "6": self = .c6
            case "5": self = .c5
            case "4": self = .c4
            case "3": self = .c3
            case "2": self = .c2
            default: return nil
            }
        }
    }

    static func customHash(_ string: String) -> Int {
        var result = ""
        string.forEach { ch in
            result += String(Alphabet(char: ch)!.rawValue)
        }
        return Int(result)!
    }

    enum Combination: Int {
        case five = 32
        case four = 17
        case fullHouse = 12
        case three = 10
        case twoPair = 9
        case onePair = 7
        case high = 5

        init?(string: String) {
            var countJ = 0
            var dictionary = string.reduce(into: [Character: Int]()) { partialResult, ch in
                if ch == "J" {
                    countJ += 1
                } else {
                    partialResult[ch, default: 0] += 1
                }
            }

            if let maxElement = dictionary.max(by: { lhs, rhs in lhs.value < rhs.value }) {
                dictionary[maxElement.key]! += countJ
            } else {
                dictionary["J"] = countJ
            }

            let result = dictionary.values.reduce(0) { partialResult, value in
                if value <= 1 {
                    return partialResult + 1
                } else {
                    return partialResult + Int(pow(2, Double(value)))
                }
            }
            self.init(rawValue: result)
        }
    }
}
