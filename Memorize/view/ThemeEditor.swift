//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Emily Thorne on 9/15/21.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    
    var body: some View {
        Form {
            nameSection
            addEmojisSection
            editNumberOfPairs
            editThemeColor
            removeEmojiSection
        }
        .navigationTitle("Edit \(theme.name)")
        .frame(minWidth: 300, minHeight: 350)
    }
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $theme.name)
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emojis in
                    addEmojis(emojis)
                }
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            emojis.forEach { emoji in
                if emoji.isEmoji && !theme.content.contains(String([emoji])) {
                    theme.content.insert(String([emoji]), at: 0)
                }
            }
        }
    }
    
    var editNumberOfPairs: some View {
        Section(header: Text("Playable Pairs")) {
            Stepper("\(theme.numPairsOfCards)", value: $theme.numPairsOfCards, in: min(2, theme.content.count)...(theme.content.count))
        }
    }

    var editThemeColor: some View {
            let colorBinding = Binding(
                get: { (Color(rgbaColor: theme.color)) },
                set: { theme.color = RGBAColor(color: $0) })
        return Section(header: Text("Theme Color")) {
            ColorPicker("Choose a Color", selection: colorBinding)
        }
    }
    
    var removeEmojiSection: some View {
        Section(header: Text("Remove Emoji")) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(theme.content, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                theme.content.removeAll(where: { $0 == emoji })
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
}

struct PaletteEditor_Previews: PreviewProvider {
    static var previews: some View {
        ThemeEditor(theme: .constant(ThemeOptions(named: "Preview").themes[4]))
            .previewLayout(.fixed(width: 300, height: 350))
        ThemeEditor(theme: .constant(ThemeOptions(named: "Preview").themes[2]))
            .previewLayout(.fixed(width: 300, height: 600))
    }
}

extension Character {
    var isEmoji: Bool {
        // Swift does not have a way to ask if a Character isEmoji
        // but it does let us check to see if our component scalars isEmoji
        // unfortunately unicode allows certain scalars (like 1)
        // to be modified by another scalar to become emoji (e.g. 1??????)
        // so the scalar "1" will report isEmoji = true
        // so we can't just check to see if the first scalar isEmoji
        // the quick and dirty here is to see if the scalar is at least the first true emoji we know of
        // (the start of the "miscellaneous items" section)
        // or check to see if this is a multiple scalar unicode sequence
        // (e.g. a 1 with a unicode modifier to force it to be presented as emoji 1??????)
        if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
            return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
        } else {
            return false
        }
    }
}
