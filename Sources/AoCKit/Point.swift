//
//  Point.swift
//  advent-of-code
//
//  Created by Andrew on 27.10.2026.
//

package struct Point: Hashable {
    package let x: Int
    package let y: Int
    
    package init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

// MARK: Arithmetic
package extension Point {
    static func + (lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func += (lhs: inout Point, rhs: Point) {
        lhs = lhs + rhs
    }
}

// MARK: - Helpres
package extension Point {
    var neighbors4: [Point] {
        return [
            Point(x: x - 1, y: y),
            Point(x: x, y: y - 1),
            Point(x: x + 1, y: y),
            Point(x: x, y: y + 1)
        ]
    }
    
    var neighbors8: [Point] {
        return [
            Point(x: x - 1, y: y - 1),
            Point(x: x - 1, y: y),
            Point(x: x - 1, y: y + 1),
            Point(x: x, y: y - 1),
            Point(x: x, y: y + 1),
            Point(x: x + 1, y: y - 1),
            Point(x: x + 1, y: y),
            Point(x: x + 1, y: y + 1),
        ]
    }
    
    func manhattanDistance(with point: Point) -> Int {
        return abs(x - point.x) + abs(y - point.y)
    }
}
