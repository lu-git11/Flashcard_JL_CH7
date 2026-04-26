//
//  DeckStore.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/23/26.
//

import Foundation
import Combine
import SwiftUI

@MainActor
class DeckStore: ObservableObject {
    @Published var decks: [DeckModel] = [] {
        didSet { save() }
    }
    
    private let store = FileStore(fileName: "decks.json")
        
    
    init(){
        load()
        if decks.isEmpty {
            decks = [DeckModel(name:"Default Deck", flashcards: [Flashcard(front: "Front", back: "Back")])]
        }
    }
    func load(){
        do{
            decks = try store.load([DeckModel].self)
        }catch{
            decks = []
            
        }
    }
    
    func save(){
        do{
            try store.save(decks)
        }catch{
            print("Error...", error)
        }
    }
    
    func deck(for deckID:UUID) -> DeckModel?{
        decks.first(where: {$0.id == deckID})
    }
    
    func addDeck(name:String){
        let newDeck:DeckModel = DeckModel(name:name, flashcards:[])
        decks.append(newDeck)
    }
    
    func deleteDeck(at offsets: IndexSet){
        decks.remove(atOffsets: offsets)
    }
    
    func addCard(to deckID:UUID, front:String, back:String){
        guard let i = decks.firstIndex(where: {$0.id == deckID}) else {
            return
        }
        decks[i].flashcards.append(Flashcard(front: front, back: back))
    }
    
    func deleteCard(in deckID: UUID, at offsets: IndexSet){
        guard let i = decks.firstIndex(where: {$0.id == deckID}) else {
            return
        }
        decks[i].flashcards.remove(atOffsets: offsets)
    }
}
