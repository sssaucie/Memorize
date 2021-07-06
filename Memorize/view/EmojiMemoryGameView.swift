//
//  ContentView.swift
//  Memorize
//
//  Created by Emily Thorne on 6/29/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var gameViewModel: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(gameViewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            gameViewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
    
    struct CardView: View {
        let card: EmojiMemoryGame.Card
        
        var body: some View {
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text(verbatim: card.content).font(.largeTitle)
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    
    // Automated code to populate view for our preview
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(gameViewModel: game)
                .preferredColorScheme(.dark)
            EmojiMemoryGameView(gameViewModel: game)
                .preferredColorScheme(.light)
        }
    }
}
