//
//  PokemonDetail.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI

struct PokemonDetail: View {
    let pokemon: PokemonModel
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: "https://archives.bulbagarden.net/media/upload/7/7d/PE_Kanto_Map.png")){ result in
                        result.image?
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(height: 300)
                    .opacity(0.75)
            
            CircleAsyncImage(imageUrl: pokemon.image.hires ?? "")
            
            PokemonInformationView(pokemon: pokemon)
                .padding(.horizontal)
        
            Spacer()
        }
        .navigationTitle(pokemon.name.english)
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
    let pokemon: PokemonModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(pokemon.name.english)
                .font(.title)
            
            HStack {
                if pokemon.type.count > 1 {
                    Text(pokemon.type[.zero].rawValue + " / " + pokemon.type[1].rawValue)
                }
                Spacer()
                Text("Kanto")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            Divider()
            
            Text(pokemon.species)
                .font(.title2)
            Text(pokemon.description)

        }
        .padding()
    }
}

#Preview {
    PokemonDetail(pokemon: pokedex[0])
}
