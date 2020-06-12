//
//  PlayingCardDeck.swift
//  DrawingCard
//
//  Created by Rustam-Deniz on 6/12/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import Foundation
struct PlayingCardDeck {
    
    ///
    /// Create a new deck of cards
    ///
    init() {
        for suit in PlayingCard.Suit.all {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }

    ///
    /// The collection of cards
    ///
    private(set) var cards = [PlayingCard]()
    
    ///
    /// Draw a card from the deck
    ///
    mutating func draw() -> PlayingCard? {
        // If there are cards, return a random one
        if cards.count > 0 {
			return cards.remove(at: Int.random(in: 0..<cards.count) )
        }
        // No more cards available
        return nil
    }
}
