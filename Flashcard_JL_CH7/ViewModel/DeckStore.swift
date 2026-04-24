//
//  DeckStore.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/23/26.
//

import Foundation
import Combine

class DeckStore: ObservableObject {
    @Published var decks: [Deck] = [
        Deck(name: "Spanish", flashcards: [
            Flashcard(front:"Hola", back:"Hello"),
            Flashcard(front:"Adios", back: "Goodbye"),
            Flashcard(front: "Playa", back: "Beach")
        ]),
        Deck(name: "French", flashcards: [
            Flashcard(front:"Oui", back:"Yes"),
            Flashcard(front:"Bonjour", back:"Hello")
        ])
    ]
}
