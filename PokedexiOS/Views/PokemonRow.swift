//
//  PokemonRow.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI

struct PokemonRow: View {
    var pokemon: Pokemon

    var body: some View {
        
        HStack {
            Text(String(pokemon.id))
                .font(.headline)
                .fontDesign(.monospaced)
            
            AsyncImage(url: URL(string: pokemon.images?.spriteURL ?? .empty)) { result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width: 80, height: 80)
            
            Text(pokemon.name?.english ?? .empty)
                .font(.headline)
                .fontDesign(.monospaced)
            
            Spacer()
            
            /*if pokemon.isFavorite ?? false {
                Image(systemName: "star.fill")
            }*/
        }
    }
}
