//
//  WishlistRepository.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import RxSwift
import Common

protocol WishlistRepository {
    func getWishlistedGames() -> Observable<[GameModel]>
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
}
