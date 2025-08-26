//
//  CoreDataStack.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 23/08/25.
//

import Foundation
import CoreData

// MARK: - Core Data Stack

class CoreDataStack {
    static let shared = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container: NSPersistentContainer = .init(name: "PokedexiOS")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Core Data error: \(error), \(error.userInfo)")
            }
            
        }
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func backgroundContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func save(_ context: NSManagedObjectContext? = nil) {
        let contextToSave: NSManagedObjectContext = context ?? self.context
        
        if contextToSave.hasChanges {
            do {
                try contextToSave.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
}

// MARK: - JSON to Core Data Manager
class JSONToCoreDataManager {
    private let coreDataStack: CoreDataStack = CoreDataStack.shared
    
    func importPokemonData(from fileName: String) {
        pokedex.forEach { pokemon in
            createPokemon(from: pokemon)
        }
        
        do {
            try coreDataStack.context.save()
            print("☑️ Imported \(pokedex.count) Pokemon")
        } catch {
            print("❌ Failed to import Pokemon: \(error)")
        }
    }
    
    // Creates a Core Data entity entry from JSON data
    private func createPokemon(from pokemonModel: PokemonModel) {
        let pokemon: Pokemon = Pokemon(context: coreDataStack.context)
        
        // Profile attributes
        createProfile(from: pokemonModel, for: pokemon)
        
        // Ability attributes
        createAbilities(from: pokemonModel.profile.ability, for: pokemon)
        
        // Type attributes
        createTypes(for: pokemon, types: pokemonModel.type)
        
        // Image attributes
        createImages(from: pokemonModel.image, for: pokemon)
        
        // Next evolution attributes
        createNextEvolutions(from: pokemonModel.evolution, for: pokemon)
        
        // Previous evolution attributes
        
        
        
        
        
         
    }
    
    private func createProfile(from pokemonModel: PokemonModel, for pokemon: Pokemon) {
        pokemon.id = Int16(pokemonModel.id)
        pokemon.pokemonDescription = pokemonModel.description
        pokemon.species = pokemonModel.species
        pokemon.weight = pokemonModel.profile.weight
        pokemon.height = pokemonModel.profile.height
        pokemon.gender = pokemonModel.profile.gender.rawValue
    }
    
    private func createAbilities(from abilities: [[String]], for pokemon: Pokemon) {
        var pokemonAbilities: Set<Ability> = []
               
       for abilityData in abilities {
           let ability = Ability(context: coreDataStack.context)
           ability.abilityName = abilityData[.zero]
           ability.isHidden = abilityData[.one]
           ability.pokemon = pokemon
           
           pokemonAbilities.insert(ability)
       }
       
       pokemon.ability = pokemonAbilities as NSSet
    }
    
    private func createTypes(for pokemon: Pokemon, types: [PokemonTypeEnum]) {
        var pokemonTypes: Set<PokemonType> = []
                
        for typeName in types {
            let pokemonType: PokemonType = PokemonType(context: coreDataStack.context)
            pokemonType.typeName = typeName.rawValue
            pokemonTypes.insert(pokemonType)
        }
        
        pokemon.type = pokemonTypes as NSSet
    }
    
    private func createImages(from image: ImageModel, for pokemon: Pokemon) {
        pokemon.images?.spriteURL = image.sprite
        pokemon.images?.thumbnailURL = image.thumbnail
        pokemon.images?.hiresURL = image.hires
    }
    
    private func createNextEvolutions(from evolution: PokemonEvolution, for pokemon: Pokemon) {
        let evolutionEntity = Evolution(context: coreDataStack.context)
        evolutionEntity.pokemon = pokemon
        
        var nextEvolutionEntities: Set<NextEvolution> = []
        
        for evolutionData in evolution.next ?? [] {
            let nextEvolution = NextEvolution(context: coreDataStack.context)
            nextEvolution.pokemonId = Int16(Int(evolutionData[.zero]) ?? .zero)
            nextEvolution.method = evolutionData[.one]
            
            nextEvolutionEntities.insert(nextEvolution)
        }
        
        evolutionEntity.nextEvolution = nextEvolutionEntities as NSSet
    }
    
    private func createPreviousEvolutions(from evolution: PokemonEvolution, for pokemon: Pokemon) {
        let evolutionEntity = Evolution(context: coreDataStack.context)
        evolutionEntity.pokemon = pokemon
        
        var previousEvolution = PreviousEvolution(context: coreDataStack.context)
        
        previousEvolution.pokemonId = Int16(Int(evolution.prev?[.zero] ?? .empty) ?? .zero)
        
        previousEvolution.method = evolution.prev?[.one] ?? .empty
    }
}
