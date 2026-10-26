/// https://adventofcode.com/2023/day/6
package struct Day06 {
    let times: [Int]
    let distances: [Int]

    package init(_ input: String) {
        let lines = input.split { $0.isNewline }
        times = lines[0].split(separator: " ").compactMap { Int($0) }
        distances = lines[1].split(separator: " ").compactMap { Int($0) }
    }

    package func part1() -> Int {
        var sum: Int = 1
        zip(times, distances).forEach { (time, maxDistance) in
            sum *= variants(time: time, maxDistance: maxDistance)
        }
        return sum
    }

    package func part2() -> Int {
        let time: Int = Int(times.reduce("") { $0 + String($1) })!
        let maxDistance: Int = Int(distances.reduce("") { $0 + String($1) })!
        return variants(time: time, maxDistance: maxDistance)
    }

    private func variants(time: Int, maxDistance: Int) -> Int {
        var leftBound = -1
        var rightBound = time / 2 // Answer
        while(rightBound - leftBound > 1) {
            let mid = (leftBound + rightBound) / 2
            let distance = distance(time: mid, fullTime: time)
            if maxDistance >= distance {
                leftBound = mid
            } else {
                rightBound = mid
            }
        }
        return ((time / 2 + 1) - rightBound) * 2 - (time % 2 == 0 ? 1 : 0)
    }

    private func distance(time: Int, fullTime: Int) -> Int {
        return (fullTime - time) * time
    }
}
