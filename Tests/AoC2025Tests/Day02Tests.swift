import AoCKit
import AoC2025
import Testing

struct Day02Tests {
    let example = """
        11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
        1698522-1698528,446443-446449,38593856-38593862,565653-565659,
        824824821-824824827,2121212118-2121212124
        """

    @Test func part1Example() {
        #expect(Day02(example).part1() == 1227775554)
    }

    @Test func part1() throws {
        let day = try Day02(input(year: 2025, day: 2))
        #expect(day.part1() == 28846518423)
    }

    @Test(.disabled("не решено: в playground части 2 была копия части 1")) func part2() throws {
        let day = try Day02(input(year: 2025, day: 2))
        #expect(day.part2() == 0)
    }
}
