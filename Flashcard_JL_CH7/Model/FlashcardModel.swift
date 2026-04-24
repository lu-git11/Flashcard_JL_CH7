//
//  FlashcardModel.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/23/26.
//

import Foundation //<-- primitive operations and types

//Model == custom type
struct Flashcard: Identifiable{
    
    let id:UUID = UUID()
    var front:String
    var back:String
    
}

struct Deck: Identifiable{
    
    let id:UUID = UUID()
    var name: String
    var flashcards: [Flashcard]
}


