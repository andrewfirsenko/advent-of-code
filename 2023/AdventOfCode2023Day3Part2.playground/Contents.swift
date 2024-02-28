import Foundation

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
    var sum: Int64 = 0
    
    func leftNumber(y: Int, x: Int) -> String? {
        guard y >= 0, y <= maxY, x >= 0, x <= maxX else { return nil }
        
        var number: String?
        for i in (0...x).reversed() {
            let ch = String(map[y][i])
            if Int(ch) != nil {
                number = ch + (number ?? "")
            } else {
                break
            }
        }
        return number
    }
    
    func rightNumber(y: Int, x: Int) -> String? {
        guard y >= 0, y <= maxY, x >= 0, x <= maxX else { return nil }
        
        var number: String?
        for i in (x...maxX) {
            let ch = String(map[y][i])
            if Int(ch) != nil {
                number = (number ?? "") + ch
            } else {
                break
            }
        }
        return number
    }
    
    map.enumerated().forEach { (y, row) in
        row.enumerated().forEach { (x, ch) in
            if ch == "*" {
                let leftTop = leftNumber(y: y - 1, x: x - 1)
                let leftMid = leftNumber(y: y, x: x - 1)
                let leftBottom = leftNumber(y: y + 1, x: x - 1)
                
                let rightTop = rightNumber(y: y - 1, x: x + 1)
                let rightMid = rightNumber(y: y, x: x + 1)
                let rightBottom = rightNumber(y: y + 1, x: x + 1)
                
                var numbers: [String] = []
                if y > 0 {
                    let chTop = String(map[y - 1][x])
                    if Int(chTop) != nil {
                        numbers.append((leftTop ?? "") + chTop + (rightTop ?? ""))
                    } else {
                        if let leftTop { numbers.append(leftTop) }
                        if let rightTop { numbers.append(rightTop) }
                    }
                }
                
                let chMid = String(map[y][x])
                if Int(chMid) != nil {
                    numbers.append((leftMid ?? "") + chMid + (rightMid ?? ""))
                } else {
                    if let leftMid { numbers.append(leftMid) }
                    if let rightMid { numbers.append(rightMid) }
                }
                
                if y < maxY {
                    let chBottom = String(map[y + 1][x])
                    if Int(chBottom) != nil {
                        numbers.append((leftBottom ?? "") + chBottom + (rightBottom ?? ""))
                    } else {
                        if let leftBottom { numbers.append(leftBottom) }
                        if let rightBottom { numbers.append(rightBottom) }
                    }
                }
                
                
                if numbers.count == 2 {
                    sum += Int64(numbers[0])! * Int64(numbers[1])!
                }
            }
        }
    }
    
    print("sum:", sum)
}

start()
