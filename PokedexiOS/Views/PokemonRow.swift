//
//  PokemonRow.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI

struct PokemonRow: View {
    var pokemon: Pokemon
    
    @available(iOS 26.0, *)
    var glassRow: some View {
        HStack {
            Text(String(pokemon.id))
                .font(.headline)
                .fontDesign(.monospaced)
                .padding(25)
            
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
        }
        .glassEffect()
    }
    
    var oldStyleRow: some View {
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
        }
    }

    var body: some View {
        if #available(iOS 26.0, *) {
            glassRow
        } else {
            oldStyleRow
        }
    }
}
