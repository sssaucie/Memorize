//
//  Theme.swift
//  Memorize
//
//  Created by Emily Thorne on 7/20/21.
//

import Foundation

struct Theme: Identifiable, Codable, Hashable {
    var name: String
    var content: [String]
    var numPairsOfCards: Int
    var color: RGBAColor

    var id: Int
    
    init(name: String, content: [String], numPairsOfCards: Int, color: RGBAColor, id: Int) {
        self.name = name
        self.content = content
        self.numPairsOfCards = numPairsOfCards > content.count ? content.count : numPairsOfCards
        self.color = color
        self.id = id
    }
}
