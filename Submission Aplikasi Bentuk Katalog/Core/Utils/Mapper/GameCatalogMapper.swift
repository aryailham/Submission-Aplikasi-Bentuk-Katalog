//
//  GameCatalogMapper.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation

class GameCatalogMapper {
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
}
