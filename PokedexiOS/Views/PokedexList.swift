//
//  PokedexList.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI

struct PokedexList: View {
    var body: some View {
        NavigationSplitView {
            List(pokedex) { pokemon in
                NavigationLink {
                    PokemonDetail(pokemon: pokemon)
                } label: {
                    PokemonRow(pokemon: pokemon)
                }
            }
            .navigationTitle("Pokedex")
        } detail: {
            Text("Select a Pokemon")
        }
    }
}

#Preview {
    PokedexList()
}
