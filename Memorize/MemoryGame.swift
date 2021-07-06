//
//  MemoryGame.swift
//  Memorize
//
//  Created by Emily Thorne on 7/5/21.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(_ card: Card) {
        
    }
    
    init(numberOfPairsOfCards: Int) {
        cards = Array<Card>()
        // add numberOfPairsOfCards x2 to cards array
        for pairIndex in (0..<numberOfPairsOfCards) {
            cards.append(Card(isFaceUp: <#T##Bool#>, isMatched: <#T##Bool#>, cardFace: <#T##CardContent#>))
        }
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var cardFace: CardContent
    }
}
