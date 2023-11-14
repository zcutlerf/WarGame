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
    
    var hasLost: Bool {
        score == 0
    }
    
    func play() -> Card {
        hand.first!
    }
}

final class PlayerTests: XCTestCase {
    func test_init_playerHasNumberAndCards() throws {
        let player = onePlayerFromTwoPlayerGame()
        XCTAssertEqual(player.number, 1)
        XCTAssertGreaterThan(player.hand.count, 0)
    }
    
    func test_score_equalToCountOfCardsInHand() throws {
        let player = onePlayerFromTwoPlayerGame()
        let score = player.score
        XCTAssertEqual(score, player.hand.count)
    }
    
    func test_hasLost_falseAtInitialization() throws {
        let player = onePlayerFromTwoPlayerGame()
        XCTAssertFalse(player.hasLost)
    }
    
    func test_play_playsFirstCardInHand() throws {
        let player = onePlayerFromTwoPlayerGame()
        let card = player.play()
        let expectedCard = player.hand.first!
        XCTAssertEqual(card, expectedCard)
    }
    
    private func onePlayerFromTwoPlayerGame() -> Player {
        let deck = Deck()
        let hand = deck.deal(to: 2).first!
        return Player(1, with: hand)
    }
}
