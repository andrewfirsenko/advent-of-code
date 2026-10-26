import AoCKit
import AoC2024
import Testing

struct Day07Tests {
    @Test func part1() throws {
        let day = try Day07(input(year: 2024, day: 7))
        #expect(day.part1() == 2664460013123)
    }

    @Test(.disabled("ответ 426214137279934 отклонён AoC: too much")) func part2() throws {
        let day = try Day07(input(year: 2024, day: 7))
        #expect(day.part2() == 0)
    }
}
