import AoCKit
import AoC2023
import Testing

struct Day05Tests {
    @Test func part1() throws {
        let day = try Day05(input(year: 2023, day: 5))
        #expect(day.part1() == 535088217)
    }

    @Test(.disabled("не решено, IOS-510")) func part2() throws {
        let day = try Day05(input(year: 2023, day: 5))
        #expect(day.part2() == 0)
    }
}
