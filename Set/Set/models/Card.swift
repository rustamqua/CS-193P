//
//  Card.swift
//  Set
//
//  Created by Rustam-Deniz on 6/4/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import Foundation
struct Card: Equatable{
	let color: Color
	let shape: Shape
	let shading: Shading
	let number: Number
	private var id: Int
	private static var idFactory: Int = 0
	static func == (lhs: Card, rhs: Card) -> Bool {
		return lhs.id == rhs.id
	}
	init(color: Color, shape: Shape, shading: Shading, number: Number) {
		Card.idFactory += 1
		id = Card.idFactory
		self.shape = shape
		self.color = color
		self.number = number
		self.shading = shading
	}
	
}

enum Color: Int, CaseIterable {
    case green = 1, purple, red
}
enum Shape: Int, CaseIterable {
    case diamond = 1, squiggle, ovale
}
enum Shading: Int, CaseIterable {
    case solid = 1, stripped, open
}
enum Number: Int, CaseIterable {
    case one = 1, two, three
}
