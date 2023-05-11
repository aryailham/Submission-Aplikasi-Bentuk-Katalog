//
//  WishlistLocalDataSource.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 11/05/23.
//

import Foundation
import CoreData

class WishlistLocalDataSource {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WishlistModel")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("error persistent container: \(error)")
            }
        }
        return container
    }()
    
    static let shared = WishlistLocalDataSource()
    
    func getWishlistedGames(completion: @escaping ([Wishlist]) -> Void) {
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wishlist")
        do {
            let results = try managedContext.fetch(fetchRequest) as! [Wishlist]
            completion(results)
        } catch let error as NSError {
            print("error fetch coredata, error: \(error)")
        }
    }
    
    func storeNewWishlist(game: GameModel) {
        let managedContext = persistentContainer.viewContext
        
        let newWishlist = Wishlist(context: managedContext)
        newWishlist.id = Int64(game.id ?? 0)
        newWishlist.name = game.name
        newWishlist.rating = game.rating ?? 0
        newWishlist.released = game.released
        newWishlist.gameDescription = game.description
        newWishlist.ratingTop = Int16(game.ratingTop ?? 0)
        newWishlist.metacritic = Int16(game.metacritic ?? 0)
        newWishlist.backgroundImage = game.backgroundImage
        game.tags.forEach { tag in
            let newTag = GameTags(context: managedContext)
            newTag.id = Int64(tag.id ?? 0)
            newTag.name = tag.name
            newWishlist.addToTags(newTag)
        }
        
        saveContext()
    }
    
    func removeWishlistedGame(gameID: Int) {
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wishlist")
        fetchRequest.predicate = NSPredicate(format: "id == \(gameID)")
        fetchRequest.fetchLimit = 1
        if let result = try? managedContext.fetch(fetchRequest), let game = result.first as? Wishlist {
            managedContext.delete(game)
        }
        
        saveContext()
    }
    
    func checkIfWishlisted(gameID: Int) -> Bool{
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wishlist")
        fetchRequest.predicate = NSPredicate(format: "id == \(gameID)")
        fetchRequest.fetchLimit = 1
        if let result = try? managedContext.fetch(fetchRequest) {
            return !result.isEmpty
        }
        return false
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("error save context: \(nserror)")
            }
        }
    }
}

extension WishlistLocalDataSource: GameDataFetcher {
    func getGameDetails(id: Int, completion: @escaping (Result<GameModel?, Error>) -> Void) {
        let managedContext = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wishlist")
        fetchRequest.predicate = NSPredicate(format: "id == \(id)")
        fetchRequest.fetchLimit = 1
        if let result = try? managedContext.fetch(fetchRequest) {
            let wishlist = GameMapper.MapGameEntityToDomainModel(gameEntity: result.first as! Wishlist)
            completion(.success(wishlist))
        }
    }
}
