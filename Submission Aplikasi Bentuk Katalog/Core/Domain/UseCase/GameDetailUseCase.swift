//
//  GameDetailUseCase.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 06/06/23.
//

import Foundation
import RxSwift

protocol GameDetailUseCase {
    func getGameDetailData(gameId: Int) -> Observable<GameModel>
    func storeNewWishlistedGames(wishlistedGame: GameModel) -> Observable<Bool>
    func removeWishlistedGames(gameId: Int) -> Observable<Bool>
    func checkIfWishlisted(gameId: Int) -> Observable<Bool>
}

class GameDetailDefaultInteractor: GameDetailUseCase {
    let repository: GameDetailRepository
    
    init(repository: GameDetailRepository) {
        self.repository = repository
    }
    
    func getGameDetailData(gameId: Int) -> Observable<GameModel> {
        return self.repository.getGameDetailData(gameId: gameId)
    }
    
    func storeNewWishlistedGames(wishlistedGame: GameModel) -> Observable<Bool> {
        return self.repository.storeNewWishlistedGames(wishlistedGame: wishlistedGame)
    }
    
    func removeWishlistedGames(gameId: Int) -> Observable<Bool> {
        return self.repository.removeWishlistedGames(gameId: gameId)
    }
    
    func checkIfWishlisted(gameId: Int) -> Observable<Bool> {
        self.repository.checkIfWishlisted(gameId: gameId)
    }
}
