//
//  Set.swift
//  Set
//
//  Created by Rustam-Deniz on 6/4/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import Foundation
struct SetGame {
	private var allCards: [Card?] = []
	var activeCards: [Card?]
	var selectedCards: [Card] = []{
		didSet{
			if selectedCards.count == 3{
				isSet()
			}
		}
	}
	var score = 0
	mutating func chooseCard(card: Card){
		selectedCards.append(card)
	}
	mutating func unchooseCard(card: Card){
		var found = 0
		for i in selectedCards.indices{
			if selectedCards[i] == card{
				found = i
			}
		}
		selectedCards.remove(at: found)
	}
	mutating func draw(){
		if activeCards.contains(nil), allCards.count != 0{
				let tempCard = allCards[0...2]
				var pointer = 0
				for i in activeCards.indices{
					if activeCards[i] == nil{
						activeCards[i] = tempCard[pointer]
						pointer+=1
					}
					if pointer == 3{
						break
					}
				}
				allCards = Array(allCards[3...])
		}
	}
	mutating func isSet(){
		let colors = Set(selectedCards.map {$0.color.rawValue})
		let shadings = Set(selectedCards.map {$0.shading.rawValue})
		let numbers = Set(selectedCards.map {$0.number.rawValue})
		let shapes = Set(selectedCards.map {$0.shape.rawValue})
		if colors.count == 2 || shadings.count == 2 || numbers.count == 2 || shapes.count == 2{
			selectedCards = []
			score-=5
		}
		else{
			for card in selectedCards{
				for cardI in activeCards.indices{
					if let activeCard = activeCards[cardI]{
						if card == activeCard{
							activeCards[cardI] = nil
						}
					}
				}
			}
			score+=3
			draw()
			selectedCards = []
		}
	}
	init() {
		for numberCase in Number.allCases{
			for colorCase in Color.allCases{
				for shadingCase in Shading.allCases{
					for shapeCase in Shape.allCases{
						allCards.append(Card(color: colorCase, shape: shapeCase, shading: shadingCase, number: numberCase))
					}
				}
			}
		}
		allCards.shuffle()
		activeCards = Array(allCards[0...11])
		allCards = Array(allCards[12...])
		let nilCards = [Card?](repeating: nil, count: 12)
		activeCards += nilCards
	}
}
