//
//  WishlistMapper.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import Common

class WishlistMapper {
    static func mapWishlistEntityToDomainModel(wishlists: [WishlistEntity]) -> [GameModel] {
        return wishlists.map { wishlist in
            var gameModel = GameModel()
            gameModel.id = Int(wishlist.id)
            gameModel.name = wishlist.name
            gameModel.released = wishlist.released
            gameModel.backgroundImage = wishlist.backgroundImage
            gameModel.rating = wishlist.rating
            gameModel.ratingTop = Int(wishlist.ratingTop)
            gameModel.metacritic = Int(wishlist.metacritic)
            gameModel.description = wishlist.gameDescription
            
            let set = Array(wishlist.tags)
            set.forEach { tags in
                var tagsModel = TagsModel()
                tagsModel.id = Int(tags.id)
                tagsModel.name = tags.name
                gameModel.tags.append(tagsModel)
            }
            return gameModel

        }
    }
    
    static func mapGameDomainModelToWishlistEntity(game: GameModel) -> WishlistEntity {
        let wishlist = WishlistEntity()
        wishlist.id = Int(game.id ?? 0)
        wishlist.name = game.name ?? ""
        wishlist.released = game.released ?? ""
        wishlist.backgroundImage = game.backgroundImage ?? ""
        wishlist.rating = game.rating ?? 0.0
        wishlist.ratingTop = Int16(game.ratingTop ?? 0)
        wishlist.metacritic = Int16(game.metacritic ?? 0)
        wishlist.gameDescription = game.description ?? ""
        
        let set = Array(game.tags)
        set.forEach { tags in
            let tagsEntity = GameTagsEntity()
            tagsEntity.id = Int64(tags.id ?? 0)
            tagsEntity.name = tags.name ?? ""
            wishlist.tags.append(tagsEntity)
        }

        return wishlist
    }
}
