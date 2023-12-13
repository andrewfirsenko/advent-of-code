import Foundation
import UIKit

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Payload

typealias DefiningHandler = (String, String) -> Bool

let digits: [String : Int] = [
    "1": 1,
    "2": 2,
    "3": 3,
    "4": 4,
    "5": 5,
    "6": 6,
    "7": 7,
    "8": 8,
    "9": 9,
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9
]

enum TickState {
    case `continue`
    case success(Int)
    case pass
}

func tick(string: String, definingHandler: DefiningHandler) -> TickState {
    var needPass = true
    for digit in digits.keys {
        if definingHandler(digit, string) {
            needPass = false
            if digit.count == string.count, let number = digits[digit] {
                return .success(number)
            }
        }
    }
    return needPass ? .pass : .continue
}

func findNumber(in string: String, definingHandler: DefiningHandler) -> Int {
    var currentString = ""
    var i = 0
    while i < string.count {
        let index = string.index(string.startIndex, offsetBy: i)
        currentString += String(string[index])
        let state = tick(string: currentString, definingHandler: definingHandler)
        switch state {
        case .continue:
            i += 1
            continue
        case .success(let number):
            return number
        case .pass:
            i -= currentString.count - 1
            i += 1
            currentString = ""
            continue
        }
    }
    
    return 0
}

// MARK: - Main

func start() {
    guard let input = loadFile(name: "Input") else {
        print("Could`t load file")
        return
    }
    
    var sum = 0
    let lines = input.split { $0.isNewline }
    let hasPrefix: (String, String) -> Bool = { digit, string in
        return digit.hasPrefix(string)
    }
    let hasSuffix: (String, String) -> Bool = { digit, string in
        let digit = String(digit.reversed())
        return digit.hasPrefix(string)
    }
    lines.forEach { line in
        let prefixNumber = findNumber(in: String(line), definingHandler: hasPrefix)
        let suffixNumber = findNumber(in: String(line.reversed()), definingHandler: hasSuffix)
        // Sum
        let numberString = String(prefixNumber) + String(suffixNumber)
        if let number = Int(numberString) {
            sum += number
        }
    }

    print("sum:", sum)
}

start()

