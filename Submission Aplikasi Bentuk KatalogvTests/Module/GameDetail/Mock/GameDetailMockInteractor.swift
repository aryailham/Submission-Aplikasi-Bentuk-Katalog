//
//  GameDetailMockInteractor.swift
//  Submission Aplikasi Bentuk KatalogvTests
//
//  Created by Arya Moehammad Ilham on 12/06/23.
//

import Foundation
import RxSwift
@testable import GameDetail
@testable import Common

enum GameDetailMockError: Error {
    case failedToAccessDataSource
}

class GameDetailEmptyMockInteractor: GameDetailUseCase {
    func getGameDetailData(gameId: Int) -> Observable<GameModel> {
        return Observable.empty()
    }
    
    func storeNewWishlistedGames(wishlistedGame: GameModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onError(GameDetailMockError.failedToAccessDataSource)
            return Disposables.create()
        }
    }
    
    func removeWishlistedGames(gameId: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onError(GameDetailMockError.failedToAccessDataSource)
            return Disposables.create()
        }
    }
    
    func checkIfWishlisted(gameId: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            observer.onError(GameDetailMockError.failedToAccessDataSource)
            return Disposables.create()
        }
    }
}

class GameDetailHasDataMockInteractor: GameDetailUseCase {
    var isWishlisted = true
    
    func getGameDetailData(gameId: Int) -> Observable<GameModel> {
        return Observable.just(GameModel())
    }
    
    func storeNewWishlistedGames(wishlistedGame: GameModel) -> Observable<Bool> {
        return Observable.just(true)
    }
    
    func removeWishlistedGames(gameId: Int) -> Observable<Bool> {
        return Observable.just(true)
    }
    
    func checkIfWishlisted(gameId: Int) -> Observable<Bool> {
        return Observable.just(self.isWishlisted)
    }
}
