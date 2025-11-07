//
//  PokemonDetail.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI

struct PokemonDetail: View {
    let pokemon: Pokemon
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: .kantoMapUrl)){ result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(height: 300)
                    .opacity(0.75)
            
            CircleAsyncImage(imageUrl: pokemon.images?.spriteURL ?? .empty)
            
            PokemonInformationView(pokemon: pokemon)
                .padding(.horizontal)
        
            Spacer()
        }
        .navigationTitle(pokemon.name?.english ?? .empty)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
    }
}

struct CircleAsyncImage: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { result in
            result.image?
                .resizable()
                .scaledToFill()
        }
        .frame(width: 210, height: 210)
        .background(Color.white)
        .clipShape(Circle())
        .offset(y: -130)
        .padding(.bottom, -130)
    }
}

struct PokemonInformationView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(pokemon.name?.english ?? .empty)
                .font(.title)
            
            HStack {
                if let types: Set<PokemonType> = pokemon.type as? Set<PokemonType> {
                    HStack(spacing: 8) {
                        ForEach(Array(types), id: \.self) { type in
                            Text(type.typeName ?? .empty)
                                .padding(8)
                        }
                    }
                }
                
                Spacer()
                Text("Kanto")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            Divider()
            
            Text(pokemon.species ?? .empty)
                .font(.title2)
            Text(pokemon.pokemonDescription ?? .empty)

        }
        .padding()
    }
}
