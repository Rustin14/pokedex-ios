//
//  PokedexiOSApp.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI
import CoreData

@main
struct PokedexiOSApp: App {
    let persistenceController = CoreDataStack.shared
    
    init() {
        let hasImported = UserDefaults.standard.bool(forKey: "hasImportedData")
        
        if !hasImported {
            PokemonDataImporter.importData(from: "pokemon.json")
            UserDefaults.standard.set(true, forKey: "hasImportedData")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
