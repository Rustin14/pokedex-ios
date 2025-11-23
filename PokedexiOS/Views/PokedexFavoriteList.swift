//
//  PokemonFavoriteList.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 13/11/25.
//

import SwiftUI

struct PokedexFavoriteList: View {
    @StateObject var viewModel: PokemonFavoritesViewModel = PokemonFavoritesViewModel()
    
    @available(iOS 26.0, *)
    var glassPokemonList: some View {
        NavigationSplitView {
            List(viewModel.filteredPokemon) { pokemon in
                NavigationLink {
                    PokemonDetail(viewModel: PokemonDetailViewModel(pokemon: pokemon))
                } label: {
                    PokemonRow(pokemon: pokemon)
                }
            }
            .onAppear {
                viewModel.fetchFavoritePokemon()
            }
            .alert("Error", isPresented: $viewModel.showError) {
                VStack {
                    Text(viewModel.errorMessage ?? .empty)
                    
                    Button("OK", role: .cancel) {}
                }
            }
            .navigationTitle("Favoritos")
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .glassEffect(in: .rect(cornerRadius: 16.0))
        } detail: {
            Text("Select a Pokemon")
        }
    }
    
    var pokemonList: some View {
        NavigationSplitView {
            List(viewModel.filteredPokemon) { pokemon in
                NavigationLink {
                    PokemonDetail(viewModel: PokemonDetailViewModel(pokemon: pokemon))
                } label: {
                    PokemonRow(pokemon: pokemon)
                }
            }
            .onAppear {
                viewModel.fetchFavoritePokemon()
            }
            .alert("Error", isPresented: $viewModel.showError) {
                VStack {
                    Text(viewModel.errorMessage ?? .empty)
                    
                    Button("OK", role: .cancel) {}
                }
            }
            .navigationTitle("Favoritos")
            .searchable(text: $viewModel.searchText, prompt: "Search")
        } detail: {
            Text("Select a Pokemon")
        }
    }
    
    var body: some View {
        if #available(iOS 26.0, *) {
            glassPokemonList
        } else {
            pokemonList
        }
    }
}

#Preview {
    PokedexFavoriteList()
}


