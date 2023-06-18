//
//  GameCatalogRepository.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation
import RxSwift
import Common

protocol GameCatalogRepository {
    func getGameCatalog() -> Observable<[GameModel]>
}

class GameCatalogDefaultRepository {
    typealias instance = (GameCatalogLocalDataSource, GameCatalogRemoteDataSource) -> GameCatalogDefaultRepository
    
    private var remote: GameCatalogRemoteDataSource
    private var local: GameCatalogLocalDataSource
    
    private init(local: GameCatalogLocalDataSource, remote: GameCatalogRemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: instance = { localRepo, remoteRepo in
        return GameCatalogDefaultRepository(local: localRepo, remote: remoteRepo)
    }
}

extension GameCatalogDefaultRepository: GameCatalogRepository {
    func getGameCatalog() -> Observable<[GameModel]> {
        return self.remote.getGameCatalog()
            .map({ responses in
                GameMapper.mapGameCatalogResponsetoEntity(gameResponse: responses)
            })
            .flatMap { entities in
                self.local.addData(from: entities)
            }
            .flatMap { _ in
                self.local.getData()
                    .map { entities in
                        GameMapper.mapGameCatalogEntityToDomainModel(gameEntity: entities)
                    }
            }

    }
}
