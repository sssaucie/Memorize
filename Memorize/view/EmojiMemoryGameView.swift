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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
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
            GeometryReader{ geometry in
                ZStack {
                    let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                    if card.isFaceUp {
                        shape.fill().foregroundColor(.white)
                        shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                        Text(card.content).font(font(in: geometry.size))
                    } else if card.isMatched {
                        shape.opacity(0)
                    } else {
                        shape.fill()
                    }
                }
            }
        }
        private func font(in size: CGSize) -> Font {
            Font.system(size: min(size.width, size.height) * DrawingConstants.fontScale)
        }
        private struct DrawingConstants {
            static let cornerRadius: CGFloat = 20
            static let lineWidth: CGFloat = 3
            static let fontScale: CGFloat = 0.75
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
