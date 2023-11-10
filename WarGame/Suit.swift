//
//  Suit.swift
//  WarGame
//
//  Created by Zoe Cutler on 11/9/23.
//

import Foundation

/// Represents a card's suit, which can be clubs, diamonds, hearts, or spades.
///
/// Conforming `Suit` to `CaseIterable` allows us to use `Suit.allCases` to iterate over all values.
enum Suit: String, CaseIterable {
    case clubs = "♣"
    case diamonds = "♦"
    case hearts = "♥"
    case spades = "♠"
}
