/// https://adventofcode.com/2024/day/2
package struct Day02 {
    let reports: [[Int]]

    package init(_ input: String) {
        reports = input.split { $0.isNewline }.map { line in
            line
                .split(separator: " ")
                .map {
                    guard let number = Int(String($0)) else { fatalError("Parse Input") }
                    return number
                }
        }
    }

    package func part1() -> Int {
        var result: Int = 0
        reports.forEach { numbers in
            let direction: Int = numbers[1] - numbers[0]
            for i in 1..<numbers.count {
                let value: Int = numbers[i] - numbers[i - 1]
                guard (value < 0 && direction < 0) || (value > 0 && direction > 0) else {
                    return
                }
                if abs(value) > 3 {
                    return
                }
            }
            result += 1
        }
        return result
    }

    package func part2() -> Int {
        var result: Int = 0
        reports.forEach { numbers in
            switch check(numbers: numbers) {
            case .success:
                result += 1
            case .failure(let index):
                var left = numbers
                left.remove(at: max(0, index - 1))
                var mid = numbers
                mid.remove(at: index)
                var right = numbers
                right.remove(at: min(numbers.count - 1, index + 1))
                switch (check(numbers: left), check(numbers: mid), check(numbers: right)) {
                case (.success, _, _): result += 1
                case (_, .success, _): result += 1
                case (_, _, .success): result += 1
                default: break
                }
            }
        }
        return result
    }
}

private enum CheckResult {
    case success
    case failure(index: Int)
}

private func check(numbers: [Int]) -> CheckResult {
    let direction: Int = numbers[0] - numbers[1]
    for i in 0..<(numbers.count - 1) {
        let value: Int = numbers[i] - numbers[i + 1]
        guard (value < 0 && direction < 0) || (value > 0 && direction > 0) else {
            return .failure(index: i)
        }
        if abs(value) > 3 {
            return .failure(index: i)
        }
    }
    return .success
}
