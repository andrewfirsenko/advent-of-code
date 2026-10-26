import AoCKit
import AoC2024
import Testing

struct Day02Tests {
    @Test func part1() throws {
        let day = try Day02(input(year: 2024, day: 2))
        #expect(day.part1() == 407)
    }

    @Test func part2() throws {
        let day = try Day02(input(year: 2024, day: 2))
        #expect(day.part2() == 459)
    }
}
