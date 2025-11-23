//
//  String+Constants.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 22/09/25.
//

extension String {
    static var fetchByIdQuery: String { return "id == %d" }
    static var fetchByFavorites: String { return "isFavorite == YES"}
    static var fetchByTypeQuery: String { return "ANY type.typeName == %@" }
    static var kantoMapUrl: String { return "https://archives.bulbagarden.net/media/upload/7/7d/PE_Kanto_Map.png" }
}
