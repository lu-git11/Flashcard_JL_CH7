//
//  AddCardView.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/26/26.
//

import SwiftUI


struct AddCardView: View {
    
    @EnvironmentObject var store: DeckStore
    @Environment(\.dismiss) private var dismiss
    
    let deckID: UUID
    
    @State var front = ""
    @State var back = ""
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Front"){
                    TextField("Question", text: $front)
                }
                Section("Back"){
                    TextField("Answer", text: $back)
                }
            }
            .navigationTitle("Add New Card")
            .toolbar{
                ToolbarItem(placement:.topBarLeading){
                    Button("Cancel"){dismiss()}
                        .foregroundStyle(.red)
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button("Add"){
                        let f = front.trimmingCharacters(in:.whitespacesAndNewlines)
                        let b = back.trimmingCharacters(in:.whitespacesAndNewlines)
                        
                        guard !f.isEmpty, !b.isEmpty else {return}
                        store.addCard(to: deckID, front: f, back: b)
                        dismiss()
                    }
                    .disabled(
                        front.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                        back.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                    )
                        
                }
            }
        }
    }
}

#Preview{
    AddCardView(deckID: UUID())
}
