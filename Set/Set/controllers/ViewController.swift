//
//  ViewController.swift
//  Set
//
//  Created by Rustam-Deniz on 6/3/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet var Cards: [UIButton]!
	var game = SetGame()

    
    @IBAction func cardSelected(_ sender: UIButton) {
		let index = Cards.firstIndex(of: sender)
		let card = game.activeCards[index!]!
		if game.selectedCards.contains(card){
			sender.layer.shadowColor = UIColor.clear.cgColor
			sender.layer.shadowOpacity = 0
			sender.layer.shadowRadius = 0
			game.unchooseCard(card: card)
		}
		else{
			sender.layer.shadowColor = UIColor.blue.cgColor
			sender.layer.shadowOpacity = 1
			sender.layer.shadowOffset = .zero
			sender.layer.shadowRadius = 4
			game.chooseCard(card: card)
		}
		if game.selectedCards.count == 0{
			for btn in Cards{
				btn.layer.shadowColor = UIColor.clear.cgColor
				btn.layer.shadowOpacity = 0
				btn.layer.shadowRadius = 0
			}
		}
		updateUI()
    }
	
	@IBAction func newGame(_ sender: UIButton) {
		game = SetGame()
		updateUI()
	}
	@IBAction func drawCards(_ sender: UIButton) {
		game.draw()
		updateUI()
	}
	override func viewDidLoad() {
        super.viewDidLoad()
		updateUI()
    }
	
	func updateUI() {
			for i in game.activeCards.indices{
				if let card = game.activeCards[i]{
					Cards[i].backgroundColor = UIColor.white
					Cards[i].isUserInteractionEnabled = true
					var title = ""
					for _ in 0..<card.number.rawValue{
						title += "\(cardShape(card: card))"
					}
					let attributes: [NSAttributedString.Key: Any] = [.strokeColor: cardColor(card: card), .foregroundColor: cardColor(card: card).withAlphaComponent(cardShading(card: card)), .strokeWidth: -3
						]
					let attributedTitle = NSAttributedString(string: title, attributes: attributes)
					Cards[i].setAttributedTitle(attributedTitle, for: .normal)
				}
				else{
					Cards[i].backgroundColor = UIColor.clear
					Cards[i].isUserInteractionEnabled = false
					Cards[i].setAttributedTitle(NSAttributedString(string: ""), for: .normal)
				}
			}
		ScoreLabel.text = "Score: \(game.score)"
	}
    
}
extension ViewController{
	func cardColor(card: Card) -> UIColor {
		switch card.color {
		case .green:
			return UIColor.green
		case .purple:
			return UIColor.purple
		case .red:
			return UIColor.red
		}
	}
	func cardShape(card: Card) -> String {
		switch card.shape {
		case .diamond:
			return "■"
		case .ovale:
			return "●"
		case .squiggle:
			return "▲"
		}
	}
	func cardShading(card: Card) -> CGFloat {
		switch card.shading {
		case .open:
			return 0.0
		case .solid:
			return 1.0
		case .stripped:
			return 0.15
		}
	}
}

