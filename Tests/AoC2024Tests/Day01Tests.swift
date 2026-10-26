import AoCKit
import AoC2024
import Testing

struct Day01Tests {
    @Test func part1() throws {
        let day = try Day01(input(year: 2024, day: 1))
        #expect(day.part1() == 1580061)
    }

    @Test func part2() throws {
        let day = try Day01(input(year: 2024, day: 1))
        #expect(day.part2() == 23046913)
    }
}
