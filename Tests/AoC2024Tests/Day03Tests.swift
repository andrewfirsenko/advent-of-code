import AoCKit
import AoC2024
import Testing

struct Day03Tests {
    @Test func part1() throws {
        let day = try Day03(input(year: 2024, day: 3))
        #expect(day.part1() == 182619815)
    }

    @Test func part2() throws {
        let day = try Day03(input(year: 2024, day: 3))
        #expect(day.part2() == 80747545)
    }
}
