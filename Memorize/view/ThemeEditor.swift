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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ThemeEditor_Previews: PreviewProvider {
    static var previews: some View {
        // Ask Brad
        ThemeEditor(theme: .constant(ThemeStore(named: "Preview").theme(at: 4)))
    }
}
