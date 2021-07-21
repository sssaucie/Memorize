//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Emily Thorne on 7/5/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
        
    private static var randomTheme = ThemeOptions.themeOptions.values.randomElement()
    
    private static let content = randomTheme!.content
    
    private static let numOfPairsOfCards = randomTheme!.numPairsOfCards
    
    let themeColor = randomTheme!.color
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: numOfPairsOfCards) { pairIndex in
            content[pairIndex] }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
        EmojiMemoryGame.randomTheme
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
        EmojiMemoryGame.randomTheme
    }
}
