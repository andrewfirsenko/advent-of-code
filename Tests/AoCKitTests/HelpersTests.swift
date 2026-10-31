//
//  HelpersTests.swift
//  advent-of-code
//
//  Created by Andrew on 31.10.2026.
//

import Testing
import AoCKit

struct HelpersTests {
    // MARK: - ints(in:)

    @Test(arguments: [
        ("42", [42]),
        ("1 2 3", [1, 2, 3]),
        ("190: 10 19", [190, 10, 19]),
        ("move 1 from 2 to 1", [1, 2, 1]),
    ])
    func testIntsPositive(string: String, expected: [Int]) {
        #expect(ints(in: string) == expected)
    }

    @Test(arguments: [
        ("-7", [-7]),
        ("x=-3, y=12", [-3, 12]),
        ("p=0,4 v=3,-3", [0, 4, 3, -3]),
        ("Sensor at x=2, y=18: closest beacon is at x=-2, y=15", [2, 18, -2, 15]),
    ])
    func testIntsNegative(string: String, expected: [Int]) {
        #expect(ints(in: string) == expected)
    }

    @Test func testIntsPlusSign() {
        #expect(ints(in: "Button A: X+94, Y+34") == [94, 34])
    }

    @Test func testIntsLastNumberAtEnd() {
        // Число в самом конце строки, без символа после него
        #expect(ints(in: "a1") == [1])
        #expect(ints(in: "a 1 b 22") == [1, 22])
    }

    @Test func testIntsLargeNumber() {
        #expect(ints(in: "426214137279934") == [426214137279934])
        #expect(ints(in: "9223372036854775807") == [Int.max])
    }

    @Test func testIntsLeadingZeros() {
        #expect(ints(in: "007 0") == [7, 0])
    }

    @Test(arguments: ["", "abc", "a - b", "-", "--", "x-y"])
    func testIntsNoNumbers(string: String) {
        #expect(ints(in: string).isEmpty)
    }

    @Test func testIntsDoubleMinus() {
        #expect(ints(in: "--5") == [-5])
    }

    @Test func testIntsTrailingMinus() {
        #expect(ints(in: "5-") == [5])
    }

    @Test func testIntsMinusBetweenDigitsIsSign() {
        // Выбранное поведение: минус всегда знак, даже между цифрами.
        // Для диапазонов вида "11-22" (2022 Day 4, 2025 Day 2) нужен ручной разбор.
        #expect(ints(in: "11-22") == [11, -22])
        #expect(ints(in: "2-4,6-8") == [2, -4, 6, -8])
    }

    @Test func testIntsMultiline() {
        #expect(ints(in: "1 2\n3\n-4") == [1, 2, 3, -4])
    }

    @Test func testIntsSubstring() {
        let lines = "a 1\nb 2".split(separator: "\n")

        #expect(ints(in: lines[1]) == [2])
    }
}
