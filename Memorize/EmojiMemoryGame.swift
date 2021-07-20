//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Emily Thorne on 7/5/21.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
        
    private static let emojis = EmojiConstants.facesEmojis
    
    private enum EmojiChoices: CGFloat {
        case animal, clothing, faces, food, holidays, household, ocean, sports
        
        func getValue() -> Array<String> {
            switch self {
            case .animal:
                return EmojiConstants.animalEmojis
            case .clothing:
                return EmojiConstants.clothingEmojis
            case .faces:
                return EmojiConstants.facesEmojis
            case .food:
                return EmojiConstants.foodEmojis
            case .holidays:
                return EmojiConstants.holidaysEmojis
            case .household:
                return EmojiConstants.householdEmojis
            case .ocean:
                return EmojiConstants.oceanEmojis
            case .sports:
                return EmojiConstants.sportsEmojis
            }
        }
    }
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 6) { pairIndex in
            emojis[pairIndex] }
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
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
