//
//  ThemeMemoryGame.swift
//  Memorize
//
//  Created by Emily Thorne on 7/20/21.
//

import Foundation

struct ThemeMemoryGame {
    var name: String
    var content: Array<String>
    var numPairsOfCards: Int
    var color: String
    
    init(name: String, content: Array<String>, numPairsOfCards: Int, color: String) {
        self.name = name
        self.content = content
        self.numPairsOfCards = numPairsOfCards > content.count ? content.count : numPairsOfCards
        self.color = color
    }
}
