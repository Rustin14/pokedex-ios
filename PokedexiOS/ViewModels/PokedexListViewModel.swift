//
//  PokedexListViewModel.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 22/09/25.
//

import Foundation
import SwiftUI
import Combine
import CoreData

class PokedexListViewModel: ObservableObject {
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
    
    init() {
        setupSearch()
    }
    
    private func setupSearch() {
        filteredPokemon = pokemon
        
        $searchText
            .combineLatest($pokemon)
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // Evita búsquedas excesivas
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
    
    // Obtener todos los Pokémon
    func fetchAllPokemons() {
        let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        
        do {
            pokemon = try context.fetch(request)
        } catch {
            showError = true
            errorMessage = error.localizedDescription
        }
    }
    
    // Buscar un Pokémon por ID
    func fetchPokemon(byId id: Int16) -> Pokemon? {
        let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        request.predicate = NSPredicate(format: .fetchByIdQuery, id)
        request.fetchLimit = .one
        
        do {
            return try context.fetch(request).first
        } catch {
            showError = true
            errorMessage = error.localizedDescription
            return nil
        }
    }
    
    // Buscar Pokémon por tipo
    func fetchPokemons(byType type: String) {
        let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        request.predicate = NSPredicate(format: .fetchByTypeQuery, type)
        
        do {
            pokemon = try context.fetch(request)
        } catch {
            showError = true
            errorMessage = error.localizedDescription
        }
    }
    
    private func fetchPokemonsForSearch() {
            let request: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
            
            if !searchText.isEmpty && !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                var predicates: [NSPredicate] = []

                let namePredicate: NSPredicate = NSPredicate(format: "(name != nil AND name CONTAINS[cd] %@)", searchText)
                
                predicates.append(namePredicate)
                
                request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
            }
            
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)]
            
            do {
                filteredPokemon = try context.fetch(request)
            } catch {
                print("Error fetching pokemons: \(error)")
                filteredPokemon = []
            }
        }
    
    // Guardar cambios
    func save() {
        CoreDataStack.shared.save()
    }
    
    
}
