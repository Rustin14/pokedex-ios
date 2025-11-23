//
//  PokemonDetail.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import SwiftUI

struct PokemonDetail: View {
    // MARK: Properties
    @ObservedObject var viewModel: PokemonDetailViewModel
    
    // MARK: States
    @State var isFavorite: Bool = false
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK:
    var body: some View {
        ScrollView {
            if let mapImage: UIImage = viewModel.mapImage {
                Image(uiImage: mapImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 275)
                        .opacity(0.75)
                        .padding(10)
            } else {
                SkeletonView(height: 275)
            }
            
            CircleAsyncImage(imageUrl: viewModel.pokemon.images?.hiresURL ?? .empty)
            
            PokemonInformationView(pokemon: viewModel.pokemon)
                .padding(.horizontal)
        
            Spacer()
        }
        .navigationTitle(viewModel.pokemon.name?.english ?? .empty)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        viewModel.toggleFavorite()
                        isFavorite = viewModel.pokemon.isFavorite
                    }
                }) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundStyle(isFavorite ? .red : .gray)
                        .scaleEffect(isFavorite ? 1.2 : 1.0)
                }
            }
        }
        .onAppear {
            isFavorite = viewModel.pokemon.isFavorite
        }
    }

}

struct CircleAsyncImage: View {
    let imageUrl: String
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { result in
            result.image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
        }
        .frame(width: 200, height: 200)
        .background(Color.white)
        .clipShape(.circle)
        .offset(y: -130)
        .padding(.bottom, -180)
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
