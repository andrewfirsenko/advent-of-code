import Foundation
import UIKit

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Main

enum Alphabet: Int64 {
    
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

extension String {
    var customHash: Int64 {
        var result = ""
        self.forEach { ch in
            result += String(Alphabet(char: ch)!.rawValue)
        }
        return Int64(result)!
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

// 255454033 - too high
// 254412181 - ok

start()
