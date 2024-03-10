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
    let commands: [Character] = lines[0].map { $0 }
    var dictionary: [String: (left: String, right: String)] = [:]
    
    lines.dropFirst().forEach { line in
        let parameters = line.split(separator: " ")
        let key = String(parameters[0])
        let left = String(parameters[2].dropFirst().dropLast())
        let right = String(parameters[3].dropLast())
        dictionary[key] = (left: left, right: right)
    }
    
    var count: Int32 = 0
    var currentStep = "AAA"
    while currentStep != "ZZZ" {
        let currentSide = commands[Int(count % Int32(commands.count))]
        if currentSide == "L" {
            currentStep = dictionary[currentStep]?.left ?? ""
        } else {
            currentStep = dictionary[currentStep]?.right ?? ""
        }
        count += 1
    }
    
    print("Answer: \(count)")
}

start()

// 14893 - ok
