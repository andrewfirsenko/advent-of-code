import AoCKit
import AoC2025
import Testing

struct Day01Tests {
    let example = """
        L68
        L30
        R48
        L5
        R60
        L55
        L1
        L99
        R14
        L82
        """

    @Test func part1Example() {
        #expect(Day01(example).part1() == 3)
    }

    @Test func part1() throws {
        let day = try Day01(input(year: 2025, day: 1))
        #expect(day.part1() == 1154)
    }

    @Test func part2Example() {
        #expect(Day01(example).part2() == 6)
    }

    @Test func part2() throws {
        let day = try Day01(input(year: 2025, day: 1))
        #expect(day.part2() == 6819)
    }
}
