import AoCKit
import AoC2024
import Testing

struct Day05Tests {
    @Test func part1() throws {
        let day = try Day05(input(year: 2024, day: 5))
        #expect(day.part1() == 6242)
    }

    @Test func part2() throws {
        let day = try Day05(input(year: 2024, day: 5))
        #expect(day.part2() == 5169)
    }
}
