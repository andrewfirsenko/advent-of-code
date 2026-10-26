import AoCKit
import AoCYYYY
import Testing

struct DayXXTests {
    let example = """

        """

    @Test func part1Example() {
        #expect(DayXX(example).part1() == 0)
    }

    // Пока ответ неизвестен, оставь `== 0`: в ошибке будет видно реальное значение.
    @Test func part1() throws {
        let day = try DayXX(input(year: YYYY, day: D))
        #expect(day.part1() == 0)
    }

    @Test func part2Example() {
        #expect(DayXX(example).part2() == 0)
    }

    @Test func part2() throws {
        let day = try DayXX(input(year: YYYY, day: D))
        #expect(day.part2() == 0)
    }
}
