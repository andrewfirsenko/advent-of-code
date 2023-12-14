import Foundation
import UIKit

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Payload

enum Color: String, RawRepresentable {
    
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



// MARK: - Main

func start() {
    guard let input = loadFile(name: "Input") else {
        print("Could`t load file")
        return
    }
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
    
    print("sum:", sum)
}

start()

