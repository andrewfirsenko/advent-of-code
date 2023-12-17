import Foundation
import UIKit

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Main

struct MapElement {
    let from: Decimal
    let to: Decimal
    let offset: Decimal
}

class Map {
    var elements: [MapElement] = []
}

func start() {
    guard let input = loadFile(name: "Input") else {
        print("Could`t load file")
        return
    }
    
    let lines = input.split { $0.isNewline }
    guard let initialLine = lines.first else { return }
    
    var numbers: [Decimal] = []
    initialLine.split(separator: " ").forEach { string in
        guard let number = Decimal(string: String(string)) else { return }
        numbers.append(number)
    }
    
    var maps: [Map] = []
    for i in 1..<lines.count {
        let line = String(lines[i])
        if line.contains("map:") {
            // Start new map
            maps.append(Map())
        } else {
            // Continue fill map
            let numbers = line.split(separator: " ").map { Decimal(string: String($0))! }
            let element = MapElement(
                from: numbers[1],
                to: numbers[1] + numbers[2],
                offset: numbers[0] - numbers[1]
            )
            maps.last?.elements.append(element)
        }
    }
    
    for i in 0..<numbers.count {
        maps.forEach { map in
            var newNumber = numbers[i]
            map.elements.forEach { mapElement in
                if numbers[i] >= mapElement.from && numbers[i] < mapElement.to {
                    newNumber = numbers[i] + mapElement.offset
                }
            }
            numbers[i] = newNumber
        }
    }
    print(numbers.min())
}

start()
