//
//  FlashcardModel.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/23/26.
//

import Foundation //<-- primitive operations and types

//Model == custom type
struct Flashcard: Identifiable, Codable, Equatable{
    
    var id:UUID
    var front:String
    var back:String
    
    init(id: UUID = UUID(), front: String, back: String){
        self.id = id
        self.front = front
        self.back = back
    }
}




