//
//  SettingsView.swift
//  Flashcard_JL_CH7
//
//  Created by jeffrey lullen on 4/23/26.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("shuffleCards") private var shuffleCards: Bool = true
    @AppStorage("cardsPerSession") private var cardsPerSession: Int = 5
    @AppStorage("SETTINGS_APPEARANCE_THEME_KEY") private var theme: Theme = .system
    @AppStorage("userFontSize") private var fontSize: Double = 16.0
    
    var body: some View{
        Form{
            Section("STUDY"){
                Toggle("Shuffle", isOn: $shuffleCards)
                Stepper("Number of Cards \(cardsPerSession)", value: $cardsPerSession, in: 1...50)
            }
            
            Section("APPEARANCE"){
                Picker("Theme", selection: $theme){
                    ForEach(Theme.allCases, id:\.self){ theme in
                        Text(theme.rawValue).tag(theme)
                    }
                }
                Text("Font Size: \(Int(fontSize))pt")
                HStack{
                    Image(systemName: "textformat.size.smaller")
                    Slider(value: $fontSize, in:12...24, step:1)
                    Image(systemName: "textformat.size.larger")
                }
            }
            Section("ABOUT"){
                Text("These setting are being persisted using UserDefaults via @AppStorage")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
        }//form end
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }//view end
}//struct end

