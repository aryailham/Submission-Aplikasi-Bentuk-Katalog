//
//  GameCatalogMapper.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation

class GameMapper {
    static func mapGameCatalogResponsetoEntity(gameResponse: [GameDataResponse]) -> [GameCatalogEntity] {
        return gameResponse.map { game in
            var entity = GameCatalogEntity()
            entity.id = Int64(game.id)
            entity.name = game.name
            entity.released = game.released
            entity.backgroundImage = game.backgroundImage
            entity.rating = game.rating
            entity.ratingTop = Int16(game.ratingTop)
            entity.metacritic = Int16(game.metacritic)
            return entity
        }
    }
    
    static func mapGameCatalogEntityToDomainModel(gameEntity: [GameCatalogEntity]) -> [GameModel] {
        return gameEntity.map { entity in
            var gameModel = GameModel()
            gameModel.id = Int(entity.id)
            gameModel.name = entity.name
            gameModel.released = entity.released
            gameModel.backgroundImage = entity.backgroundImage
            gameModel.rating = entity.rating
            gameModel.ratingTop = Int(entity.ratingTop)
            gameModel.metacritic = Int(entity.metacritic)
            return gameModel
        }
    }
    
    static func mapGameDetailResponsetoEntity(gameResponse: GameDetailsResponse) -> GameCatalogEntity {
        var entity = GameCatalogEntity()
        entity.id = Int64(gameResponse.id)
        entity.name = gameResponse.name
        entity.released = gameResponse.released
        entity.backgroundImage = gameResponse.backgroundImage
        entity.rating = gameResponse.rating
        entity.ratingTop = Int16(gameResponse.ratingTop)
        entity.metacritic = Int16(gameResponse.metacritic)
        entity.gameDescription = gameResponse.description
        
        gameResponse.tags.forEach { tags in
            var tagsEntity = GameTagsEntity()
            tagsEntity.id = Int64(tags.id)
            tagsEntity.name = tags.name
            entity.tags.append(tagsEntity)
        }
        
        return entity
    }
    
    static func mapGameDetailEntityToDomainModel(gameEntity: GameCatalogEntity) -> GameModel {
        var model = GameModel()
        model.id = Int(gameEntity.id)
        model.name = gameEntity.name
        model.released = gameEntity.released
        model.backgroundImage = gameEntity.backgroundImage
        model.rating = gameEntity.rating
        model.ratingTop = Int(gameEntity.ratingTop)
        model.metacritic = Int(gameEntity.metacritic)
        model.description = gameEntity.gameDescription
        
        let set = Array(gameEntity.tags)
        set.forEach { tags in
            var tagsEntity = TagsModel()
            tagsEntity.id = Int(tags.id)
            tagsEntity.name = tags.name
            model.tags.append(tagsEntity)
        }
        
        return model
    }

}
