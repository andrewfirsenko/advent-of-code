import Foundation
import UIKit

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Main

enum Alphabet: Int64 {
    
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

extension String {
    var customHash: Int64 {
        var sum: Int64 = 0
        self.reversed().enumerated().forEach { (index, element) in
            sum += Int64(pow(100, Double(index))) * Alphabet(char: element)!.rawValue
        }
        return sum
    }
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

struct Element {
    let combination: Combination
    let hash: Int64
    let value: Int
}

func start() {
    guard let input = loadFile(name: "Input") else {
        print("Could`t load file")
        return
    }
    
    let lines = input.split { $0.isNewline }
    var elements: [Element] = lines.map { tmp in
        let pair = tmp.split(separator: " ")
        let string = String(pair[0])
        return Element(
            combination: Combination(string: string)!,
            hash: string.customHash,
            value: Int(pair[1])!
        )
    }
    elements.sort { lhs, rhs in
        if lhs.combination == rhs.combination {
            return lhs.hash < rhs.hash
        } else {
            return lhs.combination.rawValue < rhs.combination.rawValue
        }
    }
    
    var sum: Int64 = 0
    elements.enumerated().forEach { (index, element) in
        sum += Int64(element.value * (index + 1))
    }
    print("sum: \(sum)")
}

// 256448566 - ok

start()
