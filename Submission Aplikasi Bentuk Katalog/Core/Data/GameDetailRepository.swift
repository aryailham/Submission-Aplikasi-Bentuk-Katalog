//
//  GameDetailRepository.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 06/06/23.
//

import Foundation
import RxSwift

protocol GameDetailRepository {
    func getGameDetailData(gameId: Int) -> Observable<GameModel>
    func storeNewWishlistedGames(wishlistedGame: GameModel) -> Observable<Bool>
    func removeWishlistedGames(gameId: Int)
    func checkIfWishlisted(gameId: Int) -> Observable<Bool>
}

class GameDetailDefaultRepository {
    typealias instance = (GameDetailLocalDataSource, GameDetailRemoteDataSource) -> GameDetailRepository
    
    let local: GameDetailLocalDataSource
    let remote: GameDetailRemoteDataSource
    
    private init(local: GameDetailLocalDataSource, remote: GameDetailRemoteDataSource) {
        self.local = local
        self.remote = remote
    }
    
    static let sharedInstance: instance = { localDataSource, remoteDataSource in
        return GameDetailDefaultRepository(local: localDataSource, remote: remoteDataSource)
    }
}

extension GameDetailDefaultRepository: GameDetailRepository {
    func getGameDetailData(gameId: Int) -> Observable<GameModel> {
        return self.remote.getGameDetails(id: gameId)
            .map { gameDetailResponse in
                GameMapper.mapGameDetailResponsetoEntity(gameResponse: gameDetailResponse)
            }
            .map { gameEntity in
                self.local.setGameDetailData(game: gameEntity)
            }
            .flatMap { _ in
                self.local.getGameDetailData(gameId: gameId).map { entity in
                    GameMapper.mapGameDetailEntityToDomainModel(gameEntity: entity)
                }
            }
    }
    
    func storeNewWishlistedGames(wishlistedGame: GameModel) -> Observable<Bool> {
        let wishlistEntity = WishlistMapper.mapGameDomainModelToWishlistEntity(game: wishlistedGame)
        return self.local.storeNewWishlistedGames(wishlistedGame: wishlistEntity)
    }
    
    func removeWishlistedGames(gameId: Int) {
        self.local.removeWishlistedGames(gameId: gameId)
    }
    
    func checkIfWishlisted(gameId: Int) -> Observable<Bool> {
        return self.local.checkIfWishlisted(gameId: gameId)
    }
}
