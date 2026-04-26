//
//  DeckDetailView.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/26/26.
//

import SwiftUI

struct DeckDetailView: View {
    @EnvironmentObject var store: DeckStore
    let deckID: UUID
    
    @State private var showingAddCard = false
    
    var body: some View {
        let deck = store.deck(for: deckID)
        
        List {
            if let deck {
                Section("Cards") {
                    if deck.flashcards.isEmpty{
                        Text("No Cards Yet")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(deck.flashcards) { card in
                            VStack(alignment: .leading, spacing: 6){
                                Text(card.front).font(.headline)
                                Text(card.back).foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete { offsets in store.deleteCard(in: deckID, at: offsets)
                        }
                    } // end else
                }//end section
                Section{
                    NavigationLink{
                        StudyView(deck: deck)
                    } label: {
                        Label("Study this deck", systemImage: "play.circle.fill")
                    }
                }
            } else {
                Text("Deck not found")
                    .foregroundStyle(.secondary)
            }//end if else
        }//end List
        .navigationTitle(deck?.name ?? "Deck")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing){
                Button{
                    showingAddCard = true
                } label: {
                    Image(systemName: "plus")
                }
                .disabled(deck == nil)
            }
        }
        .sheet(isPresented: $showingAddCard) {
            AddCardView(deckID: deckID)
        }
    }//end view
}// end struct
