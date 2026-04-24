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
                        // place for link to next view
                        
                    } label: {
                        VStack{
                            Text(deck.name)
                                .font(.system(size: fontSize))
                            Text("\(deck.flashcards.count) cards inside")
                                .font(.system(size: fontSize - 2))
                        }
                    }
                }//forEach end
            }//section end
        }
        .font(.system(size: fontSize))
        .navigationTitle("List of Decks")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                NavigationLink{
                    SettingsView()
                } label: {
                    Image(systemName: "gear")
                }
            }
        }//toolbar end
        .preferredColorScheme(currentTheme)
    }//view end
}//struct end

