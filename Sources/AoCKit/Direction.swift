//
//  Direction.swift
//  advent-of-code
//
//  Created by Andrew on 28.10.2026.
//

package enum Direction: CaseIterable {
    case up
    case right
    case down
    case left
}

// MARK: - Helpers
package extension Direction {
    var offset: Point {
        switch self {
        case .up:
            return Point(x: 0, y: -1)
        case .right:
            return Point(x: 1, y: 0)
        case .down:
            return Point(x: 0, y: 1)
        case .left:
            return Point(x: -1, y: 0)
        }
    }
    
    mutating func turnRight() {
        switch self {
        case .up:
            self = .right
        case .right:
            self = .down
        case .down:
            self = .left
        case .left:
            self = .up
        }
    }
    
    mutating func turnLeft() {
        switch self {
        case .up:
            self = .left
        case .right:
            self = .up
        case .down:
            self = .right
        case .left:
            self = .down
        }
    }
    
    mutating func opposite() {
        switch self {
        case .up:
            self = .down
        case .right:
            self = .left
        case .down:
            self = .up
        case .left:
            self = .right
        }
    }
}
