//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Emily Thorne on 7/5/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
//    private func save(to file: File) {
//        let data: Data = emojiCollections.json()
//        data.write(to: file)
//    }
    private(set) var theme: Theme
    
    init(theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    typealias Card = MemoryGame<String>.Card
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let shuffledItems = theme.content.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numPairsOfCards) { pairIndex in
            shuffledItems[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String>
        
    var themeName: String {
        return theme.name
    }

    var themeColor: Color {
        return Color(rgbaColor: theme.color)
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
    
    func changeTheme(to theme: Theme) {
        self.theme = theme
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }
}
