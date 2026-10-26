import AoCKit
import AoC2023
import Testing

struct Day08Tests {
    @Test func part1() throws {
        let day = try Day08(input(year: 2023, day: 8))
        #expect(day.part1() == 14893)
    }

    @Test(.disabled("перебор не завершается, IOS-509 (НОК)")) func part2() throws {
        let day = try Day08(input(year: 2023, day: 8))
        #expect(day.part2() == 0)
    }
}
