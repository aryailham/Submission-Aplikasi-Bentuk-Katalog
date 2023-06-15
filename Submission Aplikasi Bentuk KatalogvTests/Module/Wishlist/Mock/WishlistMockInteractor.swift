//
//  WishlistMockInteractor.swift
//  Submission Aplikasi Bentuk KatalogvTests
//
//  Created by Arya Moehammad Ilham on 15/06/23.
//

import Foundation
import RxSwift
@testable import Submission_Aplikasi_Bentuk_Katalog

class WishlistEmptyMockInteractor: WishlistUseCase {
    func getWishlistedGames() -> Observable<[GameModel]> {
        return Observable.empty()
    }
}

class WishlistHasDataMockInteractor: WishlistUseCase {
    func getWishlistedGames() -> Observable<[GameModel]> {
        return Observable.just([GameModel()])
    }
}