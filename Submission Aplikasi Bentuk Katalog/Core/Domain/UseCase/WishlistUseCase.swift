//
//  WishlistUseCase.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import RxSwift

protocol WishlistUseCase {
    func getWishlistedGames() -> Observable<[GameModel]>
}

protocol WishlistDetailUseCase {
    func storeNewWishlistedGames(wishlistedGame: GameModel) -> Observable<Bool>
    func removeWishlistedGames(gameId: Int)
    func checkIfWishlisted(gameId: Int) -> Observable<Bool>
}

class WishlistDefaultInteractor {
    let repository: WishlistRepository
    
    init(repository: WishlistRepository) {
        self.repository = repository
    }
}

extension WishlistDefaultInteractor: WishlistUseCase {
    func getWishlistedGames() -> Observable<[GameModel]> {
        return self.repository.getWishlistedGames()
    }
}

extension WishlistDefaultInteractor: WishlistDetailUseCase {
    func storeNewWishlistedGames(wishlistedGame: GameModel) -> Observable<Bool> {
        return self.repository.storeNewWishlistedGames(wishlistedGame: wishlistedGame)
    }
    
    func removeWishlistedGames(gameId: Int) {
        self.repository.removeWishlistedGames(gameId: gameId)
    }
    
    func checkIfWishlisted(gameId: Int) -> Observable<Bool> {
        return self.repository.checkIfWishlisted(gameId: gameId)
    }
}
