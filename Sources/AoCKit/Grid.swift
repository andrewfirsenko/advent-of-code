//
//  Grid.swift
//  advent-of-code
//
//  Created by Andrew on 31.10.2026.
//

package struct Grid<T> {
    private var grid: [[T]]
    
    package var width: Int {
        return grid.first?.count ?? .zero
    }
    
    package var height: Int {
        return grid.count
    }
    
    package init(_ input: String, transform: (Character) -> T) {
        var grid: [[T]] = []
        for line in input.split(whereSeparator: \.isNewline) {
            var gridLine: [T] = []
            for ch in line {
                gridLine.append(transform(ch))
            }
            grid.append(gridLine)
        }
        self.grid = grid
    }
}

// MARK: - Character Init
package extension Grid where T == Character {
    init(_ input: String) {
        self.init(input, transform: { $0 })
    }
}

// MARK: - Helpers
package extension Grid {
    init(width: Int, height: Int, repeating: T) {
        let line = Array(repeating: repeating, count: width)
        self.grid = Array(repeating: line, count: height)
    }
    
    subscript(_ point: Point) -> T? {
        get {
            guard point.y >= 0, point.y < height,
                  point.x >= 0, point.x < width else {
                return nil
            }
            return grid[point.y][point.x]
        }
        set {
            guard let newValue,
                  point.y >= 0, point.y < height,
                  point.x >= 0, point.x < width else {
                return
            }
            grid[point.y][point.x] = newValue
        }
    }
    
    var positions: [Point] {
        var positions: [Point] = []
        positions.reserveCapacity(width * height)
        for y in 0..<height {
            for x in 0..<width {
                positions.append(Point(x: x, y: y))
            }
        }
        return positions
    }
    
    func first(where predicate: (T) -> Bool) -> Point? {
        for (y, line) in grid.enumerated() {
            guard let x = line.firstIndex(where: predicate) else { continue }
            return Point(x: x, y: y)
        }
        return nil
    }
    
    func contains(_ point: Point) -> Bool {
        return self[point] != nil
    }
}
