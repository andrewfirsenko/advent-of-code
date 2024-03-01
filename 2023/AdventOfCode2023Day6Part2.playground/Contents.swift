import Foundation
import UIKit

// MARK: - Input

func loadFile(name: String) -> String? {
    guard let fileUrl = Bundle.main.url(forResource: name, withExtension: nil) else { return nil }
    return try? String(contentsOf: fileUrl, encoding: .utf8)
}

// MARK: - Main

func distance(time: Int64, fullTime: Int64) -> Int64 {
    return (fullTime - time) * time
}

func start() {
    guard let input = loadFile(name: "Input") else {
        print("Could`t load file")
        return
    }
    
    let lines = input.split { $0.isNewline }
    let times: [Int] = lines[0].split(separator: " ").compactMap { Int($0) }
    let distances: [Int] = lines[1].split(separator: " ").compactMap { Int($0) }
    
    var sum: Int64 = 1
    let time: Int64 = Int64(times.reduce("") { $0 + String($1) })!
    let maxDistance: Int64 = Int64(distances.reduce("") { $0 + String($1) })!
    
    var leftBound: Int64 = -1
    var rightBound: Int64 = time / 2 // Answer
    
    while(rightBound - leftBound > 1) {
        let mid = (leftBound + rightBound) / 2
        let distance = distance(time: mid, fullTime: time)
        if maxDistance >= distance {
            leftBound = mid
        } else {
            rightBound = mid
        }
    }
    
    let variants: Int64 = ((time / 2 + 1) - rightBound) * 2 - (time % 2 == 0 ? 1 : 0)
    sum *= variants
    
    
    print("Sum: \(sum)")
}

start()
