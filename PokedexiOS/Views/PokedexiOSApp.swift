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
        print("🚀 Iniciando app...")
                
            // Debug: Verificar si ya se importó
            let hasImported = UserDefaults.standard.bool(forKey: "hasImportedData")
            print("¿Datos ya importados? \(hasImported)")
            
            if !hasImported {
                print("📥 Importando datos...")
                PokemonDataImporter.importData(from: "pokemon.json")
                UserDefaults.standard.set(true, forKey: "hasImportedData")
                print("✅ Importación completada")
            }
            
            // Debug: Contar registros después de importar
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            if let count = try? persistenceController.context.count(for: request) {
                print("📊 Total Pokémon en BD: \(count)")
            }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
