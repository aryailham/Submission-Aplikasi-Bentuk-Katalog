//
//  GameDetailLocalDataSource.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 06/06/23.
//

import Foundation
import RxSwift
import RealmSwift

protocol GameDetailLocalDataSource {
    func getGameDetailData(gameId: Int) -> Observable<GameCatalogEntity>
    func setGameDetailData(game: GameCatalogEntity) -> Observable<Bool>
    func storeNewWishlistedGames(wishlistedGame: WishlistEntity) -> Observable<Bool>
    func removeWishlistedGames(gameId: Int)
    func checkIfWishlisted(gameId: Int) -> Observable<Bool>
}

class GameDetailRealmLocalDataSource {
    let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> GameDetailLocalDataSource = { realmDatabase in
        return GameDetailRealmLocalDataSource(realm: realmDatabase)
    }
}

extension GameDetailRealmLocalDataSource: GameDetailLocalDataSource {
    func getGameDetailData(gameId: Int) -> Observable<GameCatalogEntity> {
        return Observable<GameCatalogEntity>.create { observer in
            if let realm = self.realm {
                if let game = realm.object(ofType: GameCatalogEntity.self, forPrimaryKey: gameId) {
                    observer.onNext(game)
                    observer.onCompleted()
                } else {
                    observer.onError(RealmError.readError)
                }
            }
            return Disposables.create()
        }
    }
    
    func setGameDetailData(game: GameCatalogEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write({
                        realm.add(game, update: .all)
                    })
                } catch let error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func storeNewWishlistedGames(wishlistedGame: WishlistEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write({
                        realm.add(wishlistedGame, update: .all)
                    })
                } catch let error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func removeWishlistedGames(gameId: Int) {
        if let realm = self.realm {
            do {
                try realm.write({
                    if let objectToDelete = realm.object(ofType: WishlistEntity.self, forPrimaryKey: gameId) {
                        realm.delete(objectToDelete)
                    }
                })
            } catch let error {
                print("remove wishlist error: \(error.localizedDescription)")
            }
        }
    }
    
    func checkIfWishlisted(gameId: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                let data = realm.object(ofType: WishlistEntity.self, forPrimaryKey: gameId)
                
                if data != nil {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
