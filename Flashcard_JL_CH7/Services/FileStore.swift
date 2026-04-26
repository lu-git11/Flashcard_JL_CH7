//
//  FileStore.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/26/26.
//

import Foundation

enum FileStoreError: Error {
    case invalidDocumentDir
}


struct FileStore{
    
    private let fileName:String
    
    init(fileName: String = "decks.json"){
        self.fileName = fileName
    }
    
    private func fileURL() throws -> URL {
        
        guard let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw FileStoreError.invalidDocumentDir
            }
        return docs.appendingPathComponent(fileName)
    }
    // <T:Decodable> ---> Generic Types
    func load<T:Decodable>(_ type: T.Type)throws -> T {
        //get path from deck file
        let url = try fileURL()
        
        //grab data frpm a PATH
        let data = try Data(contentsOf: url)
        
        //decode data into a model
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func save<T:Encodable>(_ value:T)throws {
        let url = try fileURL()
        let data = try JSONEncoder().encode(value)
        
        try data.write(to: url,options: [.atomic])
    }
    func deleteFile() throws {
        let url = try fileURL()
        
        if FileManager.default.fileExists(atPath: url.path){
            try FileManager.default.removeItem(at: url)
        }
    }
}

