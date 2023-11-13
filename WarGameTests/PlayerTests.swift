//
//  PlayerTests.swift
//  WarGameTests
//
//  Created by Zoe Cutler on 11/13/23.
//

import XCTest

struct Player {
    var number: Int
    var hand: [Card]
    
    init(_ number: Int, with hand: [Card]) {
        self.number = number
        self.hand = hand
    }
    
    var score: Int {
        hand.count
    }
}

final class PlayerTests: XCTestCase {
    func test_init_playerHasNumberAndCards() throws {
        let deck = Deck()
        let hand = deck.deal(to: 2).first!
        let player = Player(1, with: hand)
        XCTAssertEqual(player.number, 1)
        XCTAssertGreaterThan(player.hand.count, 0)
    }
    
    func test_score_equalToCountOfCardsInHand() throws {
        let deck = Deck()
        let hand = deck.deal(to: 2).first!
        let player = Player(1, with: hand)
        let score = player.score
        XCTAssertEqual(score, player.hand.count)
    }
}
