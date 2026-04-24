//
//  Flashcard_JL_CH7App.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/23/26.
//

import SwiftUI

@main
struct Flashcard_JL_CH7App: App {
    @StateObject private var store = DeckStore()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                DeckListView()
            }//end nav 
            .environmentObject(store)
        }//end window
    }//end body
}// end struct
