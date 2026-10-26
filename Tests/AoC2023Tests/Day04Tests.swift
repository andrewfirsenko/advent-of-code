import AoCKit
import AoC2023
import Testing

struct Day04Tests {
    @Test func part1() throws {
        let day = try Day04(input(year: 2023, day: 4))
        #expect(day.part1() == 20107)
    }

    @Test func part2() throws {
        let day = try Day04(input(year: 2023, day: 4))
        #expect(day.part2() == 8172507)
    }
}
