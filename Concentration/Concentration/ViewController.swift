//
//  ViewController.swift
//  Stanford IOS
//
//  Created by Rustam-Deniz on 5/19/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    var gameTheme = GameThemes.themes.keys.randomElement()
    lazy var game = Concentration(cardsNumber: cardsCollection.count/2, emojiSet: GameThemes.themes[self.gameTheme!]!)
    var emojiMap = [Int: String]()
    
    @IBOutlet var cardsCollection: [UIButton]!
    @IBOutlet weak var FlipsCounter: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        gameTheme = GameThemes.themes.keys.randomElement()
        game = Concentration(cardsNumber: cardsCollection.count/2, emojiSet: GameThemes.themes[self.gameTheme!]!)
        emojiMap.removeAll()
        FlipsCounter.text = "Flips: 0"
        for button in cardsCollection{
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            button.setTitle("", for: UIControl.State.normal)
        }
    }
    @IBAction func toggleCard(_ sender: UIButton) {
        if let cardNumber = cardsCollection.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            toggleEvent()
            FlipsCounter.text = "Flips: \(game.score)"
        }
     }
    
    func toggleEvent() {
        for i in cardsCollection.indices{
            let button = cardsCollection[i]
            let card = game.cards[i]
            if card.isFaceUp {
                button.setTitle(emoji(for: card),for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emojiMap[card.id] == nil && game.emojiSet.count > 0 {
            let rand = Int.random(in: 0..<game.emojiSet.count)
            emojiMap[card.id] = game.emojiSet.remove(at: rand)
        }
        return emojiMap[card.id] ?? ""
    }
}

