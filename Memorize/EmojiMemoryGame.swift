//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Emily Thorne on 7/5/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    init() {
        theme = ThemeOptions.themeOptions.randomElement()!
        theme.content.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    typealias Card = MemoryGame<String>.Card
    
    private static func createMemoryGame(theme: ThemeMemoryGame) -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: theme.numPairsOfCards) { pairIndex in
            return theme.content[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
    
    private var theme: ThemeMemoryGame
    
    var themeName: String {
        return theme.name
    }
    
    var themeColor: String {
        return theme.color
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        theme = ThemeOptions.themeOptions.randomElement()!
        theme.content.shuffle()
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
