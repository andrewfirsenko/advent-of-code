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
    
    let map = input.split { $0.isNewline }.map { Array($0).filter { !$0.isWhitespace } }
    let maxY = map.count - 1
    let maxX = map[0].count - 1
    var sum = 0
    
    map.enumerated().forEach { (y, row) in
        var numberString: String = ""
        row.enumerated().forEach { (x, ch) in
            let ch = String(ch)
            let isNumber = Int(ch) != nil
            if isNumber {
                numberString += ch
            }
            
            if (!isNumber || x >= maxX), let number = Int(numberString) {
                let rightX = min(x, maxX) - (isNumber ? 0 : 1)
                let leftX = rightX - (numberString.count - 1)
                let leftTop = (x: max(leftX - 1, 0), y: max(y - 1, 0))
                let rightBottom = (x: min(rightX + 1, maxX), y: min(y + 1, maxY))
                
                var needAddSum = false
                for x in leftTop.x...rightBottom.x {
                    for y in leftTop.y...rightBottom.y {
                        let xyCh = String(map[y][x])
                        if xyCh != "." && Int(xyCh) == nil {
                            needAddSum = true
                        }
                    }
                }
                if needAddSum {
                    sum += number
                }
                numberString = ""
            }
        }
    }
    
    print("sum:", sum)
}

start()
