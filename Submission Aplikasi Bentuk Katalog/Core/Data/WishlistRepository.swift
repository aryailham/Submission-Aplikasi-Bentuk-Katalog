//
//  WishlistRepository.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import RxSwift

protocol WishlistRepository {
    func getWishlistedGames() -> Observable<[GameModel]>
    func storeNewWishlistedGames(wishlistedGame: GameModel) -> Observable<Bool>
    func removeWishlistedGames(gameId: Int)
    func checkIfWishlisted(gameId: Int) -> Observable<Bool>
}

class WishlistDefaultRepository {
    let local: WishlistLocalDataSource
    
    init(local: WishlistLocalDataSource) {
        self.local = local
    }
    
    static let sharedInstance: (WishlistLocalDataSource) -> WishlistRepository = { localDataSource in
        return WishlistDefaultRepository(local: localDataSource)
    }
}

extension WishlistDefaultRepository: WishlistRepository {
    func getWishlistedGames() -> Observable<[GameModel]> {
        return self.local.getWishlistedGames()
            .map { entities in
                WishlistMapper.mapWishlistEntityToDomainModel(wishlists: entities)
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
