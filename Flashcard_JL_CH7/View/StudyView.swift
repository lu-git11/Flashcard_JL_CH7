//
//  StudyView.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/26/26.
//

import SwiftUI



struct StudyView: View {
    let deck:DeckModel
    
    @AppStorage("shuffleCards") private var shuffleCards: Bool = true
    @AppStorage("cardsPerSession") private var cardsPerSession: Int = 5
    //show back first option iside settins
    @AppStorage("showBackFirst") var showBackFirst:Bool = false
    
    @State private var index:Int = 0
    @State private var isFlipped:Bool = false
    @State private var sessionCards:[Flashcard] = []
    
    
    var body: some View{
        VStack(spacing: 16){
            if sessionCards.isEmpty{
                Text("No cards to show")
                    .foregroundStyle(.secondary)
                Text("Add a card")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            } else {
                Text("\(index + 1) / \(sessionCards.count)")
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.thinMaterial)
                        .frame(height: 220)
                    Text(currentText)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .onTapGesture{
                    isFlipped.toggle()
                }
                HStack{
                    Button("Prev"){ prev() }
                        .buttonStyle(.bordered)
                        .disabled(index == 0)
                    
                    Button(isFlipped ? "Show Front" : "Show Back"){
                        isFlipped.toggle()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Next"){ next() }
                        .buttonStyle(.bordered)
                        .disabled(index == sessionCards.count - 1)
                }
            }
            Spacer()
        }
        .padding()
        .navigationTitle(deck.name)
        .onAppear{
            startSession()
        }
        .onChange(of: cardsPerSession){ _ in startSession() }
        .onChange(of: shuffleCards){ _ in startSession() }
        .onChange(of: showBackFirst){ _ in
            isFlipped = false
        }
    }
    
    
    private var currentText: String {
        guard !sessionCards.isEmpty else {return ""}
            
        let card = sessionCards[index]
        
        let showFront = showBackFirst ? isFlipped : !isFlipped
        
        return showFront ? card.front : card.back
        
    }
    
    private func startSession() {
        var cards = deck.flashcards
        guard !cards.isEmpty else {
            sessionCards = []
            index = 0
            isFlipped = false
            return
        }
        
        if shuffleCards{cards.shuffle()}
        
        let limit = min(cardsPerSession,cards.count)
        
        sessionCards = Array(cards.prefix(limit))
        
        index = min(index, sessionCards.count - 1)
        isFlipped = false
    }
    
    private func next(){
        guard index + 1 < sessionCards.count else { return }
            index += 1
            isFlipped = false
    }
    
    private func prev(){
        guard index - 1 >= 0 else  { return }
            index -= 1
            isFlipped = false
    }
}


#Preview{
    NavigationStack{
        StudyView(deck:DeckModel(
            name:"Default deck",
            flashcards:[
                Flashcard(front:"Front", back:"back")
            ]
        ))
    }
}
