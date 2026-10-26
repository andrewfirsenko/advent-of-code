import Testing
import AoCKit

struct InputTests {
    @Test func pathIsZeroPadded() {
        #expect(inputURL(year: 2024, day: 6).path().hasSuffix("/Inputs/2024/day06.txt"))
    }

    @Test func missingInputExplainsWhereToGetIt() {
        #expect {
            try input(year: 1999, day: 1)
        } throws: { error in
            "\(error)".contains("https://adventofcode.com/1999/day/1/input")
        }
    }
}
