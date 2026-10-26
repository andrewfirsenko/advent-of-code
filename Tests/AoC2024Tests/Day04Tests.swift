import AoCKit
import AoC2024
import Testing

struct Day04Tests {
    @Test func part1() throws {
        let day = try Day04(input(year: 2024, day: 4))
        #expect(day.part1() == 2390)
    }

    @Test func part2() throws {
        let day = try Day04(input(year: 2024, day: 4))
        #expect(day.part2() == 1809)
    }
}
