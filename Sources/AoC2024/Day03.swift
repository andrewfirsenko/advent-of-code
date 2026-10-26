import Foundation

/// https://adventofcode.com/2024/day/3
package struct Day03 {
    let input: String

    package init(_ input: String) {
        self.input = input
    }

    package func part1() -> Int {
        sumOfMuls(in: input)
    }

    package func part2() -> Int {
        var correctInput: String = ""
        var tempInput: String = input
        var addLastPart: Bool = false
        while let dontMatch = tempInput.firstMatch(of: /don't\(\)/) {
            correctInput += tempInput[..<dontMatch.startIndex]
            addLastPart = false
            if let doMatch = tempInput[dontMatch.endIndex...].firstMatch(of: /do\(\)/) {
                tempInput = String(tempInput[doMatch.endIndex...])
                addLastPart = true
            }
        }
        if addLastPart {
            correctInput += tempInput
        }
        return sumOfMuls(in: correctInput)
    }

    private func sumOfMuls(in text: String) -> Int {
        let regexPattern: String = "mul\\([0-9]{1,3},[0-9]{1,3}\\)"
        var result: Int = 0
        matches(pattern: regexPattern, text: text).forEach { mulString in
            let numbers: [Int] = mulString
                .matches(of: /[0-9]+/)
                .map { match in
                    Int(match.output) ?? 0
                }
            result += numbers.reduce(1, *)
        }
        return result
    }
}

private func matches(pattern: String, text: String) -> [String] {
    guard let regex: NSRegularExpression = try? NSRegularExpression(pattern: pattern) else {
        fatalError("Invalid init regex")
    }
    let results: [String] = regex
        .matches(in: text, range: NSRange(location: 0, length: text.utf16.count))
        .compactMap {
            guard let range: Range = Range($0.range, in: text) else { return nil }
            return String(text[range])
        }
    return results
}
