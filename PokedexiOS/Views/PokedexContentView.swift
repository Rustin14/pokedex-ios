//
//  ContentView.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI

struct PokedexContentView: View {
    let persistenceController = CoreDataStack.shared

    var body: some View {
        TabView {
            Tab("Pokedex", image: "pokeBall") {
                PokedexList()
                    .environment(\.managedObjectContext, persistenceController.context)
            }
            
            Tab("Favoritos", systemImage: "star.fill") {
                PokedexFavoriteList(viewModel: PokemonFavoritesViewModel())
            }
            
            Tab("Configuración", systemImage: "gear.circle") {
                
            }
        }
    }
}

#Preview {
    PokedexContentView()
}
