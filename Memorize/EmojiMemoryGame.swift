//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Emily Thorne on 7/5/21.
//

import SwiftUI

class EmojiMemoryGame {
    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: 4)
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
