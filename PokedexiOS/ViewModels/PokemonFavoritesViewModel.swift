//
//  PokemonFavoritesViewModel.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 13/11/25.
//

import Foundation
import CoreData
import UIKit
import Combine

class PokemonFavoritesViewModel: ObservableObject {
    // MARK: Published Properties
    @Published var pokemon: [Pokemon] = []
    @Published var filteredPokemon: [Pokemon] = []
    @Published var searchText: String = .empty
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError: Bool = false
    
    // MARK: Properties
    private let context = CoreDataStack.shared.context
    
    // MARK: Dependencies
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: Publishers
    private let refreshTrigger: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
    
    // MARK: Initializer
    init() {
        setupSearch()
    }
    
    // MARK: Functions
    private func setupSearch() {
        filteredPokemon = pokemon
        
        $searchText
            .combineLatest($pokemon)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .map { searchText, pokemon in
                guard !searchText.isEmpty else {
                    return pokemon
                }
                return pokemon.filter { pokemon in
                    guard let pokemonNames: Name = pokemon.name,
                            let englishPokemonName: String = pokemonNames.english else {
                        return false
                    }
                    return englishPokemonName.localizedCaseInsensitiveContains(searchText)
                }
            }
            .assign(to: &$filteredPokemon)
    }
    
    func fetchFavoritePokemon(){
        let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        request.predicate = NSPredicate(format: .fetchByFavorites)
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]

        do {
            pokemon = try context.fetch(request)
        } catch {
            showError = true
            errorMessage = error.localizedDescription
        }
    }
    
}
