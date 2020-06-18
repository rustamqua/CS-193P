//
//  ViewController.swift
//  DrawingCard
//
//  Created by Rustam-Deniz on 6/12/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var deck = PlayingCardDeck()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
	
	@IBOutlet weak var playingCardView: DrawnCard!{
		didSet{
			let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
			swipe.direction = [.left, .right]
			playingCardView.addGestureRecognizer(swipe)
		}
	}
	
	@IBAction func flipCard(_ sender: UITapGestureRecognizer) {
		playingCardView.isFaceUp = !playingCardView.isFaceUp
	}
	@objc
	func nextCard() {
		if let card = deck.draw(){
			playingCardView.rank = card.rank.order
			playingCardView.suit = card.suit.rawValue
		}
	}
}

