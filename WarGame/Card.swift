//
//  Card.swift
//  WarGame
//
//  Created by Zoe Cutler on 11/9/23.
//

import Foundation

/// Represents a card, with a value and suit.
///
/// Conforming `Card` to `Comparable` allows us to compare instances using operators like `<`, `>`, and `==`.
struct Card: Comparable {
    let value: Value
    let suit: Suit
    
    /// A human-readable description of a card, showing it's value and suit.
    var description: String {
        "\(value.description)\(suit.rawValue)"
    }
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        lhs.value < rhs.value
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.value == rhs.value
    }
}
