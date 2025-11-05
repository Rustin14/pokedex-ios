//
//  PokedexList.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI

struct PokedexList: View {
    @StateObject private var viewModel: PokedexListViewModel = PokedexListViewModel()
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.pokemon) { pokemon in
                NavigationLink {
                    PokemonDetail(pokemon: pokemon)
                } label: {
                    PokemonRow(pokemon: pokemon)
                }
            }
            .onAppear {
                viewModel.fetchAllPokemons()
            }
            .alert("Error", isPresented: $viewModel.showError) {
                VStack {
                    Text(viewModel.errorMessage ?? .empty)
                    
                    Button("OK", role: .cancel) {}
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
