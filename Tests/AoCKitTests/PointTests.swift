//
//  PointTests.swift
//  advent-of-code
//
//  Created by Andrew on 27.10.2026.
//

import Testing
import AoCKit

struct PointTests {
    @Test func testNeighbors4Positive() {
        let centerPoint = Point(x: 4, y: 5)
        let expected = [
            Point(x: 3, y: 5),
            Point(x: 4, y: 4),
            Point(x: 5, y: 5),
            Point(x: 4, y: 6)
        ]
        
        #expect(centerPoint.neighbors4 == expected)
    }
    
    @Test func testNeighbors4Zero() {
        let centerPoint = Point(x: 0, y: 0)
        let expected = [
            Point(x: -1, y: 0),
            Point(x: 0, y: -1),
            Point(x: 1, y: 0),
            Point(x: 0, y: 1)
        ]
        
        #expect(centerPoint.neighbors4 == expected)
    }
    
    @Test func testNeighbors8Positive() {
        let centerPoint = Point(x: 4, y: 5)
        let expected = [
            Point(x: 3, y: 4),
            Point(x: 3, y: 5),
            Point(x: 3, y: 6),
            Point(x: 4, y: 4),
            Point(x: 4, y: 6),
            Point(x: 5, y: 4),
            Point(x: 5, y: 5),
            Point(x: 5, y: 6),
        ]
        
        #expect(centerPoint.neighbors8 == expected)
    }
    
    @Test func testNeighbors8Zero() {
        let centerPoint = Point(x: 0, y: 0)
        let expected = [
            Point(x: -1, y: -1),
            Point(x: -1, y: 0),
            Point(x: -1, y: 1),
            Point(x: 0, y: -1),
            Point(x: 0, y: 1),
            Point(x: 1, y: -1),
            Point(x: 1, y: 0),
            Point(x: 1, y: 1),
        ]
        
        #expect(centerPoint.neighbors8 == expected)
    }
    
    @Test func testManhattanDistacnePositivePoints() {
        let from = Point(x: 5, y: 6)
        let to = Point(x: 8, y: 10)
        
        #expect(from.manhattanDistance(with: to) == 7)
        #expect(to.manhattanDistance(with: from) == 7)
    }
    
    @Test func testManhattanDistacneNegativePoints() {
        let from = Point(x: 5, y: 6)
        let to = Point(x: -8, y: -10)
        
        #expect(from.manhattanDistance(with: to) == 29)
        #expect(to.manhattanDistance(with: from) == 29)
    }
    
    @Test func testManhattanDistacneZeroPoints() {
        let from = Point(x: 0, y: 0)
        let to = Point(x: 0, y: 0)
        
        #expect(from.manhattanDistance(with: to) == 0)
        #expect(to.manhattanDistance(with: from) == 0)
    }

    @Test func testPlus() {
        let lhs = Point(x: 1, y: 2)
        let rhs = Point(x: 3, y: -5)

        #expect(lhs + rhs == Point(x: 4, y: -3))
        #expect(rhs + lhs == Point(x: 4, y: -3))
    }

    @Test func testPlusZero() {
        let point = Point(x: 7, y: -2)
        let zero = Point(x: 0, y: 0)

        #expect(point + zero == point)
    }

    @Test func testPlusAssignment() {
        var point = Point(x: 1, y: 1)
        point += Point(x: 2, y: 3)

        #expect(point == Point(x: 3, y: 4))
    }

    @Test func testPlusAssignmentNegative() {
        var point = Point(x: 1, y: 1)
        point += Point(x: -4, y: -1)

        #expect(point == Point(x: -3, y: 0))
    }
}
