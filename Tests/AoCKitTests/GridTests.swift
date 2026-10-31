//
//  GridTests.swift
//  advent-of-code
//
//  Created by Andrew on 31.10.2026.
//

import Testing
import AoCKit

struct GridTests {
    /// Неквадратная сетка 4×2: на квадратной перепутанные x и y не видны.
    let rectangle = Grid("""
        abcd
        efgh
        """)

    // MARK: - Init

    @Test func testInitSize() {
        #expect(rectangle.width == 4)
        #expect(rectangle.height == 2)
    }

    @Test func testInitTrailingNewline() {
        let grid = Grid("ab\ncd\n")

        #expect(grid.width == 2)
        #expect(grid.height == 2)
    }

    @Test func testInitWindowsNewlines() {
        let grid = Grid("ab\r\ncd")

        #expect(grid.height == 2)
        #expect(grid[Point(x: 1, y: 0)] == "b")
        #expect(grid[Point(x: 0, y: 1)] == "c")
    }

    @Test func testInitSingleLine() {
        let grid = Grid("abc")

        #expect(grid.width == 3)
        #expect(grid.height == 1)
    }

    @Test func testInitEmpty() {
        let grid = Grid("")

        #expect(grid.width == 0)
        #expect(grid.height == 0)
        #expect(grid.positions.isEmpty)
        #expect(grid[Point(x: 0, y: 0)] == nil)
    }

    @Test func testInitTransform() {
        let grid = Grid("123\n456") { $0.wholeNumberValue! }

        #expect(grid.width == 3)
        #expect(grid.height == 2)
        #expect(grid[Point(x: 0, y: 0)] == 1)
        #expect(grid[Point(x: 2, y: 1)] == 6)
    }

    @Test func testInitRepeating() {
        let grid = Grid(width: 3, height: 2, repeating: false)

        #expect(grid.width == 3)
        #expect(grid.height == 2)
        #expect(grid.positions.allSatisfy { grid[$0] == false })
    }

    // MARK: - Subscript get

    @Test func testSubscriptCorners() {
        #expect(rectangle[Point(x: 0, y: 0)] == "a")
        #expect(rectangle[Point(x: 3, y: 0)] == "d")
        #expect(rectangle[Point(x: 0, y: 1)] == "e")
        #expect(rectangle[Point(x: 3, y: 1)] == "h")
    }

    @Test(arguments: [
        Point(x: -1, y: 0),  // слева
        Point(x: 0, y: -1),  // сверху
        Point(x: 4, y: 0),   // x == width
        Point(x: 0, y: 2),   // y == height
        Point(x: -1, y: -1),
        Point(x: 4, y: 2),
        Point(x: 100, y: 100),
    ])
    func testSubscriptOutOfBoundsIsNil(point: Point) {
        #expect(rectangle[point] == nil)
    }

    // MARK: - Subscript set

    @Test func testSubscriptSetInside() {
        var grid = rectangle
        grid[Point(x: 2, y: 1)] = "X"

        #expect(grid[Point(x: 2, y: 1)] == "X")
        #expect(grid[Point(x: 1, y: 1)] == "f")
        #expect(grid[Point(x: 2, y: 0)] == "c")
    }

    @Test func testSubscriptSetOutsideIsIgnored() {
        var grid = rectangle
        grid[Point(x: -1, y: 0)] = "X"
        grid[Point(x: 4, y: 0)] = "X"
        grid[Point(x: 0, y: 2)] = "X"

        #expect(grid.width == 4)
        #expect(grid.height == 2)
        #expect(grid.positions.allSatisfy { grid[$0] != "X" })
    }

    @Test func testSubscriptSetNilIsIgnored() {
        var grid = rectangle
        grid[Point(x: 0, y: 0)] = nil

        #expect(grid[Point(x: 0, y: 0)] == "a")
    }

    @Test func testSubscriptSetDoesNotChangeCopy() {
        let original = rectangle
        var copy = original
        copy[Point(x: 0, y: 0)] = "X"

        #expect(original[Point(x: 0, y: 0)] == "a")
    }

    // MARK: - Positions

    @Test func testPositionsCount() {
        #expect(rectangle.positions.count == 8)
        #expect(Set(rectangle.positions).count == 8)
    }

    @Test func testPositionsRowByRow() {
        #expect(rectangle.positions == [
            Point(x: 0, y: 0), Point(x: 1, y: 0), Point(x: 2, y: 0), Point(x: 3, y: 0),
            Point(x: 0, y: 1), Point(x: 1, y: 1), Point(x: 2, y: 1), Point(x: 3, y: 1),
        ])
    }

    @Test func testPositionsAreInside() {
        #expect(rectangle.positions.allSatisfy { rectangle.contains($0) })
    }

    // MARK: - First where

    @Test func testFirstWhereSingleMatch() {
        #expect(rectangle.first { $0 == "g" } == Point(x: 2, y: 1))
    }

    @Test func testFirstWhereReturnsFirstInRowOrder() {
        let grid = Grid("""
            ..#.
            .#..
            #...
            """)

        #expect(grid.first { $0 == "#" } == Point(x: 2, y: 0))
    }

    @Test func testFirstWhereEarlierRowWinsOverSmallerX() {
        // В строке 1 совпадение левее, но строка 0 идёт раньше
        let grid = Grid("""
            ...#
            #...
            """)

        #expect(grid.first { $0 == "#" } == Point(x: 3, y: 0))
    }

    @Test func testFirstWhereNoMatch() {
        #expect(rectangle.first { $0 == "z" } == nil)
    }

    @Test func testFirstWhereMatchesPositionsOrder() {
        let grid = Grid("""
            .a.
            a.a
            """)
        let expected = grid.positions.first { grid[$0] == "a" }

        #expect(grid.first { $0 == "a" } == expected)
    }

    // MARK: - Contains

    @Test func testContains() {
        #expect(rectangle.contains(Point(x: 0, y: 0)))
        #expect(rectangle.contains(Point(x: 3, y: 1)))
        #expect(!rectangle.contains(Point(x: 4, y: 1)))
        #expect(!rectangle.contains(Point(x: 3, y: 2)))
        #expect(!rectangle.contains(Point(x: -1, y: 0)))
    }

    // MARK: - Neighbors inside grid

    @Test(arguments: [
        (Point(x: 0, y: 0), 2, 3),  // угол
        (Point(x: 1, y: 0), 3, 5),  // край
        (Point(x: 1, y: 1), 4, 8),  // центр
    ])
    func testNeighborsInsideGrid(point: Point, count4: Int, count8: Int) {
        let grid = Grid("""
            ...
            ...
            ...
            """)

        #expect(point.neighbors4.filter { grid.contains($0) }.count == count4)
        #expect(point.neighbors8.filter { grid.contains($0) }.count == count8)
    }
}
