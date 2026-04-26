//
//  DeckListView.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/23/26.
//

import SwiftUI

struct DeckListView:View {
    
    @EnvironmentObject var store: DeckStore
    @AppStorage("cardsPerSession") var cardsPerSession: Int = 5
    @AppStorage("SETTINGS_APPEARANCE_THEME_KEY") private var theme: Theme = .system
    @AppStorage("userFontSize") private var fontSize: Double = 16.0
    
    @State private var showingAddDeck = false
    
    var currentTheme: ColorScheme? {
        switch theme {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    var body: some View {
        List{
            Text("Cards Per Session \(cardsPerSession)")
            Stepper("Cards Per Session \(cardsPerSession)", value: $cardsPerSession,in: 1...50)
            
            Section("CARDS"){
                
                ForEach(store.decks){ deck in
                    NavigationLink{
                        DeckDetailView(deckID: deck.id)
                        } label: {
                            VStack(alignment: .leading, spacing: 4){
                                Text(deck.name)
                                    .font(.system(size: fontSize))
                            Text("\(deck.flashcards.count) cards inside")
                                .font(.system(size: fontSize - 2))
                        }
                    }
                }//forEach end
                .onDelete(perform: store.deleteDeck)
            }//section end
        }
        .font(.system(size: fontSize))
        .navigationTitle("List of Decks")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                    EditButton()
                }
                ToolbarItem(placement: .topBarTrailing){
                    Button{ showingAddDeck = true } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarTrailing){
                    NavigationLink{ SettingsView() } label: {
                        Image(systemName: "gear")
                    }
                }
            }//toolbar end
            .preferredColorScheme(currentTheme)
            .sheet(isPresented: $showingAddDeck){
                AddDeckView()
            }
    }//view end
}//struct end

