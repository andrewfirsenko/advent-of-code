/// https://adventofcode.com/2024/day/1
package struct Day01 {
    let leftNumbers: [Int]
    let rightNumbers: [Int]

    package init(_ input: String) {
        var leftNumbers: [Int] = []
        var rightNumbers: [Int] = []
        let lines = input.split { $0.isNewline }
        lines.forEach { line in
            let params = line.split(separator: " ")
            guard let leftNumber: Int = Int(String(params[0])),
                  let rightNumber: Int = Int(String(params[1])) else {
                fatalError("Parse Input")
            }
            leftNumbers.append(leftNumber)
            rightNumbers.append(rightNumber)
        }
        self.leftNumbers = leftNumbers
        self.rightNumbers = rightNumbers
    }

    package func part1() -> Int {
        var result: Int = 0
        zip(leftNumbers.sorted(by: <), rightNumbers.sorted(by: <)).forEach { left, right in
            result += abs(left - right)
        }
        return result
    }

    package func part2() -> Int {
        var result: Int = 0
        var dict: [Int: Int] = [:]
        rightNumbers.forEach { right in
            dict[right, default: 0] += 1
        }
        leftNumbers.forEach { left in
            if let value = dict[left] {
                result += left * value
            }
        }
        return result
    }
}
