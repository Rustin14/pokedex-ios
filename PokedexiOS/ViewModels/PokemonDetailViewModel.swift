//
//  PokemonDetailViewModel.swift
//  PokedexiOS
//
//  Created by Gabriel Flores on 13/11/25.
//

import Foundation
import CoreData
import UIKit

// ViewModel
class PokemonDetailViewModel: ObservableObject {
    // MARK: Published Properties
    @Published var pokemon: Pokemon
    @Published var mapImage: UIImage? = nil
    
    // MARK: Properties
    private let context: NSManagedObjectContext
    private let imageCache: NSCache = NSCache<AnyObject, AnyObject>()
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
        self.context = CoreDataStack.shared.context
        loadImageAndCacheIt(urlString: .kantoMapUrl)
    }
    
    func toggleFavorite() {
        pokemon.isFavorite.toggle()
        
        do {
            try context.save()
        } catch {
            print("Error: \(error)")
        }
    }
    
    private func loadImageAndCacheIt(urlString: String) {
        guard let url: URL = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            if let _ = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    self.imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.mapImage = imageToCache
                }
            }
        }.resume()
    }
}
