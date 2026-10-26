import AoCKit
import AoC2023
import Testing

struct Day03Tests {
    @Test func part1() throws {
        let day = try Day03(input(year: 2023, day: 3))
        #expect(day.part1() == 540025)
    }

    @Test func part2() throws {
        let day = try Day03(input(year: 2023, day: 3))
        #expect(day.part2() == 84584891)
    }
}
