import AoCKit
import AoC2023
import Testing

struct Day02Tests {
    @Test(.disabled("решение части 1 не сохранилось")) func part1() throws {
        let day = try Day02(input(year: 2023, day: 2))
        #expect(day.part1() == 0)
    }

    @Test func part2() throws {
        let day = try Day02(input(year: 2023, day: 2))
        #expect(day.part2() == 86036)
    }
}
