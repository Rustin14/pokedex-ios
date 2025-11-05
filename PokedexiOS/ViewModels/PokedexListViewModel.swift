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
    
    // Guardar cambios
    func save() {
        CoreDataStack.shared.save()
    }
    
    
}
