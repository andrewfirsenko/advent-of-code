/// https://adventofcode.com/2023/day/8
package struct Day08 {
    let commands: [Character]
    let dictionary: [String: (left: String, right: String)]

    package init(_ input: String) {
        let lines = input.split { $0.isNewline }
        commands = lines[0].map { $0 }
        var dictionary: [String: (left: String, right: String)] = [:]
        lines.dropFirst().forEach { line in
            let parameters = line.split(separator: " ")
            let key = String(parameters[0])
            let left = String(parameters[2].dropFirst().dropLast())
            let right = String(parameters[3].dropLast())
            dictionary[key] = (left: left, right: right)
        }
        self.dictionary = dictionary
    }

    package func part1() -> Int {
        var count: Int = 0
        var currentStep = "AAA"
        while currentStep != "ZZZ" {
            let currentSide = commands[count % commands.count]
            if currentSide == "L" {
                currentStep = dictionary[currentStep]?.left ?? ""
            } else {
                currentStep = dictionary[currentStep]?.right ?? ""
            }
            count += 1
        }
        return count
    }

    /// Не решено: перебор не завершается на настоящем вводе. IOS-509 (НОК).
    package func part2() -> Int {
        var currentSteps: [String] = dictionary.keys.filter { $0.last == "A" }
        var count: Int = 0
        while !currentSteps.allSatisfy({ $0.last == "Z" }) {
            let currentSide = commands[count % commands.count]
            if currentSide == "L" {
                for i in 0..<currentSteps.count {
                    currentSteps[i] = dictionary[currentSteps[i]]?.left ?? ""
                }
            } else {
                for i in 0..<currentSteps.count {
                    currentSteps[i] = dictionary[currentSteps[i]]?.right ?? ""
                }
            }
            count += 1
        }
        return count
    }
}
