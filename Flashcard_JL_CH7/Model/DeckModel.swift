//
//  DeckModel.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/26/26.
//

import Foundation

struct DeckModel: Identifiable, Codable, Equatable{
    
    var id: UUID
    var name: String
    var flashcards: [Flashcard]
    
    init(id:UUID = UUID(), name: String = "New Deck", flashcards: [Flashcard]){
        self.id = id
        self.name = name
        self.flashcards = flashcards
    }
}
