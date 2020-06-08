//
//  GameThemes.swift
//  Stanford IOS
//
//  Created by Rustam-Deniz on 5/29/20.
//  Copyright © 2020 Rustam-Deniz. All rights reserved.
//

import Foundation
class GameThemes {
    static var themes = ["halloween": ["😈","👽","🎩","🐼","🧞‍♂️","🐸","🕸", "🦇"], "clothes": ["🧥", "👚", "👕", "👖", "👔", "👗", "👙", "👘", "👠", "👡", "👢", "👞", "👟", "🥾", "🥿", "🧦", "🧤", "🧣"], "animals": ["🦓", "🦍", "🐘", "🦏", "🦛", "🐪", "🐫", "🦙", "🦒", "🐃", "🐂", "🐄", "🐎", "🐖", "🐏", "🐑", "🐐", "🦌"]]
    static func addTheme(name: String, theme: [String]){
        themes[name] = theme
    }
    init(newThemes: [String:[String]]) {
        GameThemes.themes = newThemes
    }
}
