//
//  Helpers.swift
//  advent-of-code
//
//  Created by Andrew on 31.10.2026.
//

package func ints(in string: some StringProtocol) -> [Int] {
    var numbers: [Int] = []
    var current: [Character] = []
    
    func addIfPossible() {
        guard let number = Int(String(current)) else { return }
        numbers.append(number)
    }
    
    for ch in string {
        if ch.isNumber {
            current.append(ch)
            continue
        }
        
        if ch == "-" {
            addIfPossible()
            current.removeAll()
            current.append(ch)
            continue
        }
        
        addIfPossible()
        current.removeAll()
    }
    addIfPossible()
    
    return numbers
}
