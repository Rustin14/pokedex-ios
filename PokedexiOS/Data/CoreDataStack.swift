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
        let container: NSPersistentContainer = .init(name: "PokemonDataModel")
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
class PokemonDataImporter {
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
        createPreviousEvolutions(from: pokemonModel.evolution, for: pokemon)
        
        //Egg groups attributes
        createEggGroups(from: pokemonModel.profile.egg ?? [], for: pokemon)
    }
    
    private func createProfile(from pokemonModel: PokemonModel, for pokemon: Pokemon) {
        pokemon.id = Int16(pokemonModel.id)
        pokemon.name = Name(context: coreDataStack.context)
        pokemon.name?.english = pokemonModel.name.english
        pokemon.name?.chinese = pokemonModel.name.chinese
        pokemon.name?.french = pokemonModel.name.french
        pokemon.name?.japanese = pokemonModel.name.japanese
        pokemon.pokemonDescription = pokemonModel.description
        pokemon.species = pokemonModel.species
        pokemon.weight = pokemonModel.profile.weight
        pokemon.height = pokemonModel.profile.height
        pokemon.gender = pokemonModel.profile.gender.rawValue
        pokemon.isFavorite = false
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
        let imageEntity: Images = Images(context: coreDataStack.context)
        imageEntity.spriteURL = image.sprite
        imageEntity.thumbnailURL = image.thumbnail
        imageEntity.hiresURL = image.hires
        
        pokemon.images = imageEntity
    }
    
    private func createNextEvolutions(from evolution: PokemonEvolution, for pokemon: Pokemon) {
        // Necesitas obtener o crear la entidad Evolution
        let evolutionEntity: Evolution
        if let existingEvolution = pokemon.evolution {
            evolutionEntity = existingEvolution
        } else {
            evolutionEntity = Evolution(context: coreDataStack.context)
            evolutionEntity.pokemon = pokemon
            pokemon.evolution = evolutionEntity // ¡Asignar la relación!
        }
        
        var nextEvolutionEntities: Set<NextEvolution> = []
        
        for evolutionData in evolution.next ?? [] {
            let nextEvolution = NextEvolution(context: coreDataStack.context)
            nextEvolution.pokemonId = Int16(Int(evolutionData[.zero]) ?? .zero)
            nextEvolution.method = evolutionData[.one]
            nextEvolution.evolution = evolutionEntity // Asignar relación inversa
            
            nextEvolutionEntities.insert(nextEvolution)
        }
        
        evolutionEntity.nextEvolution = nextEvolutionEntities as NSSet
    }

    private func createPreviousEvolutions(from evolution: PokemonEvolution, for pokemon: Pokemon) {
        // Reutilizar la misma entidad Evolution
        let evolutionEntity: Evolution
        if let existingEvolution = pokemon.evolution {
            evolutionEntity = existingEvolution
        } else {
            evolutionEntity = Evolution(context: coreDataStack.context)
            evolutionEntity.pokemon = pokemon
            pokemon.evolution = evolutionEntity
        }
        
        if let prevData = evolution.prev {
            let previousEvolution = PreviousEvolution(context: coreDataStack.context)
            previousEvolution.pokemonId = Int16(Int(prevData[.zero]) ?? .zero)
            previousEvolution.method = prevData[.one]
            previousEvolution.evolution = evolutionEntity // Asignar relación inversa
            
            // Asignar evolución a pokemon
        }
    }
    
    private func createEggGroups(from eggGroups: [PokemonEgg], for pokemon: Pokemon) {
        var eggGroupsEntities: Set<EggGroup> = []
        
        for eggGroupData in eggGroups {
            let eggGroup = EggGroup(context: coreDataStack.context)
            eggGroup.groupName = eggGroupData.rawValue
            eggGroup.pokemon = pokemon // Asignar relación inversa
            eggGroupsEntities.insert(eggGroup)
        }
        
        pokemon.eggGroup = eggGroupsEntities as NSSet
    }
}

extension PokemonDataImporter {
    /// Convenience method to import data from CoreDataStack
    static func importData(from fileName: String) {
        let dataImporter = PokemonDataImporter()
        dataImporter.importPokemonData(from: fileName)
    }
}


