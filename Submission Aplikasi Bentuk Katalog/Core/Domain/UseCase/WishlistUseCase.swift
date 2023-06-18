//
//  WishlistUseCase.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import RxSwift
import Common

protocol WishlistUseCase {
    func getWishlistedGames() -> Observable<[GameModel]>
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
