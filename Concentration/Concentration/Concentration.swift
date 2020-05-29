//
//  Concentration.swift
//  Stanford IOS
//
//  Created by Rustam-Deniz on 5/20/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import Foundation
class Concentration {
    var cards: [Card] = []
    var exactCard: Int?
    var score = 0
    var seenCards = [Card]()
    var emojiSet = [String]()
    func chooseCard(at index: Int){
        if !cards[index].isMatched{
            if let matchIndex = exactCard, matchIndex != index{
                if cards[matchIndex].id == cards[index].id{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score+=2
                }
                else{
                    if seenCards.contains(cards[exactCard!]) && seenCards.contains(cards[index]){
                        score-=1
                    }

                }
                cards[index].isFaceUp = true
                if !seenCards.contains(cards[index]){
                    seenCards.append(cards[index])
                }
                exactCard = nil
            }
            else{
                for i in cards.indices {
                    if cards[i].isFaceUp{
                        cards[i].isFaceUp = false
                    }
                }
                cards[index].isFaceUp = true
                if !seenCards.contains(cards[index]){
                    seenCards.append(cards[index])
                }
                exactCard = index
            }
        }
    }
    init(cardsNumber: Int, emojiSet: [String]) {
        for _ in 0..<cardsNumber {
            let card1 = Card(first: true)
            let card2 = Card(first: false)
            Card.lastId += 1
            self.cards += [card1, card2]
        }
        self.emojiSet = emojiSet
        cards.shuffle()
    }
}
