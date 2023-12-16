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
    
    let lines = input.split { $0.isNewline }
    var cards = [Int](repeating: 1, count: lines.count)
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
        
        for offset in 0..<winConunt {
            let offsetIndex = index + offset + 1
            guard offsetIndex < lines.count else { return }
            
            cards[offsetIndex] = cards[offsetIndex] + cards[index]
        }
    }
    
    print(cards.reduce(0, +))
}

start()
