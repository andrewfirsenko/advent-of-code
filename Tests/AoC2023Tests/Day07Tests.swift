import AoCKit
import AoC2023
import Testing

struct Day07Tests {
    @Test func part1() throws {
        let day = try Day07(input(year: 2023, day: 7))
        #expect(day.part1() == 256448566)
    }

    @Test func part2() throws {
        let day = try Day07(input(year: 2023, day: 7))
        #expect(day.part2() == 254412181)
    }
}
