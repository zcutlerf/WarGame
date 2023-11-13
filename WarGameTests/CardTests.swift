//
//  CardTests.swift
//  WarGameTests
//
//  Created by Zoe Cutler on 11/13/23.
//

import XCTest

struct Card: Comparable {
    var value: Value
    var suit: Suit
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        lhs.value < rhs.value
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        lhs.value == rhs.value
    }
}

enum Value: Int, Comparable {
    case two = 2
    case three, four, five, six, seven, eight, nine, ten, jack, king, queen, ace
    
    static func < (lhs: Value, rhs: Value) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    static func == (lhs: Value, rhs: Value) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

enum Suit {
    case clubs, diamonds, hearts, spades
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
}
