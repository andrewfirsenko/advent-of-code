//
//  DirectionTests.swift
//  advent-of-code
//
//  Created by Andrew on 28.10.2026.
//

import Testing
import AoCKit

struct DirectionTests {
    // MARK: - AllCases
    
    @Test func testAllCasesClockwise() {
        #expect(Direction.allCases == [.up, .right, .down, .left])
    }

    // MARK: - Offset

    @Test func testOffset() {
        // y растёт вниз
        #expect(Direction.up.offset == Point(x: 0, y: -1))
        #expect(Direction.right.offset == Point(x: 1, y: 0))
        #expect(Direction.down.offset == Point(x: 0, y: 1))
        #expect(Direction.left.offset == Point(x: -1, y: 0))
    }

    @Test(arguments: Direction.allCases)
    func testOffsetIsOneStep(direction: Direction) {
        let zero = Point(x: 0, y: 0)

        #expect(direction.offset.manhattanDistance(with: zero) == 1)
    }

    @Test func testOffsetsMatchNeighbors4() {
        let point = Point(x: 4, y: 5)
        let moved = Direction.allCases.map { point + $0.offset }

        #expect(Set(moved) == Set(point.neighbors4))
    }

    // MARK: - Turn right

    @Test func testTurnRightClockwise() {
        var direction = Direction.up

        direction.turnRight()
        #expect(direction == .right)
        direction.turnRight()
        #expect(direction == .down)
        direction.turnRight()
        #expect(direction == .left)
        direction.turnRight()
        #expect(direction == .up)
    }

    @Test(arguments: Direction.allCases)
    func testTurnRightFourTimesReturnsBack(direction: Direction) {
        var turned = direction
        for _ in 0..<4 {
            turned.turnRight()
        }

        #expect(turned == direction)
    }

    // MARK: - Turn left

    @Test func testTurnLeftCounterClockwise() {
        var direction = Direction.up

        direction.turnLeft()
        #expect(direction == .left)
        direction.turnLeft()
        #expect(direction == .down)
        direction.turnLeft()
        #expect(direction == .right)
        direction.turnLeft()
        #expect(direction == .up)
    }

    @Test(arguments: Direction.allCases)
    func testTurnLeftFourTimesReturnsBack(direction: Direction) {
        var turned = direction
        for _ in 0..<4 {
            turned.turnLeft()
        }

        #expect(turned == direction)
    }

    @Test(arguments: Direction.allCases)
    func testTurnLeftUndoesTurnRight(direction: Direction) {
        var turned = direction
        turned.turnRight()
        turned.turnLeft()

        #expect(turned == direction)
    }

    @Test(arguments: Direction.allCases)
    func testTurnRightOffsetIsRotated(direction: Direction) {
        // Поворот направо на 90° при y вниз: (x, y) -> (-y, x)
        var turned = direction
        turned.turnRight()

        #expect(turned.offset == Point(x: -direction.offset.y, y: direction.offset.x))
    }

    // MARK: - Opposite

    @Test func testOpposite() {
        var up = Direction.up
        var right = Direction.right
        var down = Direction.down
        var left = Direction.left

        up.opposite()
        right.opposite()
        down.opposite()
        left.opposite()

        #expect(up == .down)
        #expect(right == .left)
        #expect(down == .up)
        #expect(left == .right)
    }

    @Test(arguments: Direction.allCases)
    func testOppositeOffsetCancels(direction: Direction) {
        var opposite = direction
        opposite.opposite()

        #expect(direction.offset + opposite.offset == Point(x: 0, y: 0))
    }

    @Test(arguments: Direction.allCases)
    func testOppositeTwiceReturnsBack(direction: Direction) {
        var turned = direction
        turned.opposite()
        turned.opposite()

        #expect(turned == direction)
    }

    @Test(arguments: Direction.allCases)
    func testOppositeEqualsTwoRightTurns(direction: Direction) {
        var opposite = direction
        opposite.opposite()
        var turned = direction
        turned.turnRight()
        turned.turnRight()

        #expect(opposite == turned)
    }
}
