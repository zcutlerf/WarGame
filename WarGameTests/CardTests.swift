//
//  CardTests.swift
//  WarGameTests
//
//  Created by Zoe Cutler on 11/13/23.
//

import XCTest

struct Card: Comparable, CustomStringConvertible {
    var value: Value
    var suit: Suit
    
    var description: String {
        "\(value.description)\(suit.description)"
    }
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        lhs.value < rhs.value
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.value == rhs.value
    }
}

enum Value: Int, Comparable, CustomStringConvertible, CaseIterable {
    case two = 2
    case three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
    static func < (lhs: Value, rhs: Value) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    static func == (lhs: Value, rhs: Value) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
    
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
}

enum Suit: String, CustomStringConvertible, CaseIterable {
    case clubs, diamonds, hearts, spades
    
    var description: String {
        switch self {
        case .clubs:
            "♣"
        case .diamonds:
            "♦"
        case .hearts:
            "♥"
        case .spades:
            "♠"
        }
    }
}

final class CardTests: XCTestCase {
    func test_greaterThan_aceOfSpadesIsGreaterThanKingOfSpades() throws {
        let aceOfSpades = Card(value: .ace, suit: .spades)
        let kingOfSpades = Card(value: .king, suit: .spades)
        
        XCTAssert(aceOfSpades > kingOfSpades)
    }
    
    func test_equality_aceOfSpadesEqualsAceOfHearts() throws {
        let aceOfSpades = Card(value: .ace, suit: .spades)
        let aceOfHearts = Card(value: .ace, suit: .hearts)
        
        XCTAssertEqual(aceOfSpades, aceOfHearts)
    }
    
    func test_description_forKingOfSpades() throws {
        let kingOfSpades = Card(value: .king, suit: .spades)
        let description = kingOfSpades.description
        
        XCTAssertEqual(description, "K♠")
    }
}
