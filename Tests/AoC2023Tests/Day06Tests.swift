import AoCKit
import AoC2023
import Testing

struct Day06Tests {
    @Test func part1() throws {
        let day = try Day06(input(year: 2023, day: 6))
        #expect(day.part1() == 32076)
    }

    @Test func part2() throws {
        let day = try Day06(input(year: 2023, day: 6))
        #expect(day.part2() == 34278221)
    }
}
