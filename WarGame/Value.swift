//
//  Value.swift
//  WarGame
//
//  Created by Zoe Cutler on 11/9/23.
//

import Foundation

/// Represents a card's value, with 2 being low and Ace being high.
///
/// Conforming `Value` to `CaseIterable` allows us to use `Value.allCases` to iterate over all values.
/// Conforming `Value` to `Comparable` allows us to compare instances using operators like `<`, `>`, and `==`.
enum Value: Int, CaseIterable, Comparable {
    case two = 2
    case three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
    /// A human-readable description of a value, showing the numerical or face value.
    var description: String {
        switch self {
        case .two:
            "2"
        case .three:
            "3"
        case .four:
            "4"
        case .five:
            "5"
        case .six:
            "6"
        case .seven:
            "7"
        case .eight:
            "8"
        case .nine:
            "9"
        case .ten:
            "10"
        case .jack:
            "J"
        case .queen:
            "Q"
        case .king:
            "K"
        case .ace:
            "A"
        }
    }
    
    static func < (lhs: Value, rhs: Value) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    static func == (lhs: Value, rhs: Value) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
