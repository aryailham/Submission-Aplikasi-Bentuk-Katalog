//
//  GameMapper.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 11/05/23.
//

import Foundation

class GameMapper {
    static func MapGameResponseToDomainModel(gameResponse: GameDetailsResponse) -> GameModel {
        var gameModel = GameModel()
        gameModel.id = gameResponse.id
        gameModel.name = gameResponse.name
        gameModel.released = gameResponse.released
        gameModel.backgroundImage = gameResponse.backgroundImage
        gameModel.rating = gameResponse.rating
        gameModel.ratingTop = gameResponse.ratingTop
        gameModel.metacritic = gameResponse.metacritic
        gameModel.description = gameResponse.description
        
        gameResponse.tags.forEach { tags in
            var tagsModel = TagsModel()
            tagsModel.id = tags.id
            tagsModel.name = tags.name
            gameModel.tags.append(tagsModel)
        }
        return gameModel
    }
    
    static func MapGameEntityToDomainModel(gameEntity: Wishlist) -> GameModel {
        var gameModel = GameModel()
        gameModel.id = Int(gameEntity.id)
        gameModel.name = gameEntity.name
        gameModel.released = gameEntity.released
        gameModel.backgroundImage = gameEntity.backgroundImage
        gameModel.rating = gameEntity.rating
        gameModel.ratingTop = Int(gameEntity.ratingTop)
        gameModel.metacritic = Int(gameEntity.metacritic)
        gameModel.description = gameEntity.gameDescription
        
        let set = gameEntity.tags?.allObjects as! [GameTags]
        set.forEach { tags in
            var tagsModel = TagsModel()
            tagsModel.id = Int(tags.id)
            tagsModel.name = tags.name
            gameModel.tags.append(tagsModel)
        }
        return gameModel

    }
}
