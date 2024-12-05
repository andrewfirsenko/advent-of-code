import Foundation

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Main

func main() {
    guard let input = loadFile(name: "Input") else {
        fatalError("Couldn`t load the file")
    }
    
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
    
    var result: Int = 0
    let regexPattern: String = "mul\\([0-9]{1,3},[0-9]{1,3}\\)"
    matches(pattern: regexPattern, text: correctInput).forEach { mulString in
        let numbers: [Int] = mulString
            .matches(of: /[0-9]+/)
            .map { match in
                Int(match.output) ?? 0
            }
        result += numbers.reduce(1, *)
    }
    
    print("answer:", result)
}

func matches(pattern: String, text: String) -> [String] {
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

main()

