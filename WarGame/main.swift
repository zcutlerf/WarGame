//
//  main.swift
//  WarGame
//
//  Created by Zoe Cutler on 11/9/23.
//

import Foundation

// Make a deck of shuffled cards
let deck = Deck()

// Deal the cards by dealing to a certain number of players
let dividedCards = deck.dealTo(2)

// Make players and give them their cards
var players = dividedCards.indices.map { index in
    Player(index + 1, unturnedCards: dividedCards[index])
}

// Make a War game to represent game state
var war = War(players: players)

// Play the War game
war.playGame()
