//
//  PokemonModel.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 28/03/25.
//

import Foundation

// MARK: - Pokemon struct
struct PokemonModel: Decodable, Identifiable {
    let id: Int
    let isFavorite: Bool?
    let name: PokemonName
    let type: [PokemonTypeEnum]
    let base: BasePoints?
    let species, description: String
    let evolution: PokemonEvolution
    let profile: PokemonProfile
    let image: ImageModel
}

// MARK: - BasePoints struct
struct BasePoints: Decodable {
    let hp, attack, defense, spAttack: Int
    let spDefense, speed: Int

    enum CodingKeys: String, CodingKey {
        case hp = "HP"
        case attack = "Attack"
        case defense = "Defense"
        case spAttack = "Sp. Attack"
        case spDefense = "Sp. Defense"
        case speed = "Speed"
    }
}

// MARK: - PokemonEvolution struct
struct PokemonEvolution: Decodable {
    let next: [[String]]?
    let prev: [String]?
}

// MARK: - ImageModel struct
struct ImageModel: Decodable {
    let sprite, thumbnail: String
    let hires: String?
}

// MARK: - PokemonName struct
struct PokemonName: Decodable {
    let english, japanese, chinese, french: String
}

// MARK: - PokemonProfile struct
struct PokemonProfile: Decodable {
    let height, weight: String
    let egg: [PokemonEgg]?
    let ability: [[String]]
    let gender: PokemonGender
}

// MARK: - Egg enumeration
enum PokemonEgg: String, Decodable {
    case amorphous = "Amorphous"
    case bug = "Bug"
    case ditto = "Ditto"
    case dragon = "Dragon"
    case fairy = "Fairy"
    case field = "Field"
    case flying = "Flying"
    case grass = "Grass"
    case humanLike = "Human-Like"
    case mineral = "Mineral"
    case monster = "Monster"
    case undiscovered = "Undiscovered"
    case water1 = "Water 1"
    case water2 = "Water 2"
    case water3 = "Water 3"
}

// MARK: - Gender enumeration
enum PokemonGender: String, Decodable {
    case genderless = "Genderless"
    case the001000 = "0.0:100.0"
    case the0100 = "0:100"
    case the1000 = "100:0"
    case the100000 = "100.0:0.0"
    case the125875 = "12.5:87.5"
    case the250750 = "25.0:75.0"
    case the2575 = "25:75"
    case the500500 = "50.0:50.0"
    case the5050 = "50:50"
    case the7525 = "75:25"
    case the875125 = "87.5:12.5"
}

// MARK: - PokemonType enumeration
enum PokemonTypeEnum: String, Decodable {
    case bug = "Bug"
    case dark = "Dark"
    case dragon = "Dragon"
    case electric = "Electric"
    case fairy = "Fairy"
    case fighting = "Fighting"
    case fire = "Fire"
    case flying = "Flying"
    case ghost = "Ghost"
    case grass = "Grass"
    case ground = "Ground"
    case ice = "Ice"
    case normal = "Normal"
    case poison = "Poison"
    case psychic = "Psychic"
    case rock = "Rock"
    case steel = "Steel"
    case water = "Water"
}
