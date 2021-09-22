//
//  ThemeChooser.swift
//  Memorize
//
//  Created by Emily Thorne on 9/15/21.
//

import SwiftUI

struct ThemeChooser: View {
    
    @EnvironmentObject var store: ThemeStore
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    // Ask Brad about theme.id
                    // Navigate to the GAME duh
                    NavigationLink(destination: ThemeEditor(theme: $store.themes[theme.id])) {
                        VStack(alignment: .leading) {
                            Text(theme.name)
                            // Add card pairs view
                            Text(theme.content)
                        }
                        .gesture(editMode == .active ? tap : nil)
                    }
                }
                .onDelete { indices in
                    store.themes.remove(atOffsets: indices)
                }
                .onMove { indices, newOffset in
                    store.themes.move(fromOffsets: indices, toOffset: newOffset)
                }
            }
            .navigationTitle("Manage Themes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if presentationMode.wrappedValue.isPresented,
                       UIDevice.current.userInterfaceIdiom != .pad {
                        Button("Close") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
    var tap: some Gesture {
        TapGesture().onEnded {  }
    }
}

