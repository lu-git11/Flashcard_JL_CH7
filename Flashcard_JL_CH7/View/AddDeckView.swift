//
//  AddDeckView.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/26/26.
//

import SwiftUI

struct AddDeckView: View {
    
    @EnvironmentObject var store:DeckStore
    @Environment(\.dismiss) private var dismiss
    @State var name: String = ""
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name of the Deck", text: $name)
            }
            .navigationTitle("Add New Deck")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Cancel"){dismiss()}
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add"){
                        let t = name.trimmingCharacters(in: .whitespacesAndNewlines)
                        
                        guard !t.isEmpty else {return}
                        
                        store.addDeck(name: t)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}
#Preview{
    NavigationStack{
        AddDeckView()
    }
}
