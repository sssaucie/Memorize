//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Emily Thorne on 9/15/21.
//

import SwiftUI

struct ThemeChooser: View {
    
    @EnvironmentObject var options: ThemeOptions
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editMode: EditMode = .inactive
    
    @State private var themeToEdit: Theme?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(options.themes) { theme in
                    themeDescription(of: theme)
                }
                .onDelete { indexSet in
                    options.themes.remove(atOffsets: indexSet)
                }
                .onMove { indices, newOffset in
                    options.themes.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .navigationTitle("Memorize")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem { EditButton() }
                ToolbarItem(placement: .navigationBarLeading) {
                    addTheme
                }
            }
            .popover(item: $themeToEdit, content: { theme in
                ThemeEditor(theme: $options.themes[options.themes.firstIndex(where: { $0.id == theme.id })!])
            })
            .environment(\.editMode, $editMode)
        }
    }
    
    func themeDescription(of theme: Theme) -> some View {
        NavigationLink(destination: EmojiMemoryGameView(gameViewModel: EmojiMemoryGame(theme: theme))) {
            VStack(alignment: .leading) {
                Text(theme.name.capitalized).font(.title).foregroundColor(Color.init(rgbaColor: theme.color))
                Text(theme.content.joined())
            }
            .gesture(editMode == .active ? editTap(of: theme) : nil)
        }
    }
    
    var addTheme: some View {
        Button {
            options.insertTheme(named: "New", content: [], numPairsOfCards: 0, themeColor: .black)
            themeToEdit = options.themes.last
        } label: {
            Image(systemName: "plus")
        }
    }
    
    func editTap(of theme: Theme) -> some Gesture {
        TapGesture (count: 1)
            .onEnded {
                themeToEdit = theme
            }
    }
}

