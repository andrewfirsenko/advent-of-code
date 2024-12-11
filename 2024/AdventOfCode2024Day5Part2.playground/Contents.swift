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
    
    var result: Int = 0
    
    splitInput[1].split(whereSeparator: \.isNewline).forEach { line in
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
    
    print("answer:", result)
}
main()
