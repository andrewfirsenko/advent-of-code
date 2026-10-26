import AoCKit
import AoC2024
import Testing

struct Day06Tests {
    @Test func part1() throws {
        let day = try Day06(input(year: 2024, day: 6))
        #expect(day.part1() == 5404)
    }

    @Test func part2() throws {
        let day = try Day06(input(year: 2024, day: 6))
        #expect(day.part2() == 530)
    }
}
