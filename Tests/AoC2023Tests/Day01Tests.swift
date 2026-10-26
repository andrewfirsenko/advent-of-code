import AoCKit
import AoC2023
import Testing

struct Day01Tests {
    @Test(.disabled("решение части 1 не сохранилось")) func part1() throws {
        let day = try Day01(input(year: 2023, day: 1))
        #expect(day.part1() == 0)
    }

    @Test func part2() throws {
        let day = try Day01(input(year: 2023, day: 1))
        #expect(day.part2() == 54649)
    }
}
