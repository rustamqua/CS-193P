//
//  Card.swift
//  Stanford IOS
//
//  Created by Rustam-Deniz on 5/20/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import Foundation
struct Card: Equatable {
    var id: Int
    var isMatched: Bool = false
    var isFaceUp: Bool = false
    var first: Bool
    static var lastId: Int = 0
    static func == (lhs: Card, rhs: Card) -> Bool{
        return lhs.id==rhs.id && lhs.first==rhs.first
    }
    init(first: Bool) {
        id = Card.lastId
        self.first = first
    }
}

