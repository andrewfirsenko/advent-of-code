import Foundation

/// https://adventofcode.com/2024/day/7
package struct Day07 {
    let lines: [Substring]

    package init(_ input: String) {
        lines = input.split { $0.isNewline }
    }

    package func part1() -> Int {
        var result: Int = 0
        lines.forEach { line in
            guard let splitIndex = line.firstIndex(of: ":"),
                  let sumNumber: Int = Int(String(line[line.startIndex..<splitIndex])) else {
                return
            }
            let numbers: [Int] = line[splitIndex..<line.endIndex]
                .split(separator: " ")
                .compactMap { Int(String($0)) }
                .reversed()
            if !numbers.isEmpty,
               determine(result: numbers.last!, reversedNumbers: numbers.dropLast(), condition: sumNumber) {
                result += sumNumber
            }
        }
        return result
    }

    /// Ответ 426214137279934 AoC отклонил: «too much».
    package func part2() -> Int {
        var result: Decimal = 0
        lines.forEach { line in
            guard let splitIndex = line.firstIndex(of: ":"),
                  let target: Decimal = Decimal(string: String(line[line.startIndex..<splitIndex])) else {
                return
            }
            let numbers: [Decimal] = line[splitIndex..<line.endIndex]
                .split(separator: " ")
                .compactMap { Decimal(string: String($0)) }
            if dfs(i: 1, result: numbers[0], target: target, nums: numbers) {
                result += target
            }
        }
        return NSDecimalNumber(decimal: result).intValue
    }
}

private func determine(result: Int, reversedNumbers: [Int], condition: Int) -> Bool {
    if result == condition { return true }
    if result > condition || reversedNumbers.isEmpty { return false }
    let nextNumber: Int = reversedNumbers.last!
    let newReversedNumbers: [Int] = reversedNumbers.dropLast()
    return determine(result: result + nextNumber, reversedNumbers: newReversedNumbers, condition: condition) ||
    determine(result: result * nextNumber, reversedNumbers: newReversedNumbers, condition: condition)
}

private func dfs(i: Int, result: Decimal, target: Decimal, nums: [Decimal]) -> Bool {
    if result == target { return true }
    if i >= nums.count || result > target { return false }
    return dfs(i: i + 1, result: result + nums[i], target: target, nums: nums) ||
    dfs(i: i + 1, result: result * nums[i], target: target, nums: nums) ||
    dfs(i: i + 1, result: Decimal(string: "\(result)\(nums[i])")!, target: target, nums: nums)
}
