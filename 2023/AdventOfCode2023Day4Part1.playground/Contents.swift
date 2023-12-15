import Foundation
import UIKit

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Main

func start() {
    guard let input = loadFile(name: "Input") else {
        print("Could`t load file")
        return
    }
    
    var sum: Decimal = 0
    let lines = input.split { $0.isNewline }
    lines.enumerated().forEach { (index, line) in
        // given
        var numbers: Set<Int> = []
        var winConunt: Int = 0
        let line: String = String(line)
        guard let startIndex = line.firstIndex(of: ":"),
              let middleIndex = line.firstIndex(of: "|") else { return }
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
        
        // result
        if winConunt > 0 {
            let points = pow(2, winConunt - 1)
            sum += points
        }
    }
    
    print(sum)
}

start()
