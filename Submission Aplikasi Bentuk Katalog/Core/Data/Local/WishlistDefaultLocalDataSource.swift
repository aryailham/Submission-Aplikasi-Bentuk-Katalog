//
//  WishlistDefaultLocalDataSource.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import RxSwift
import RealmSwift

protocol WishlistLocalDataSource {
    func getWishlistedGames() -> Observable<[WishlistEntity]>
    func storeNewWishlistedGames(wishlistedGame: WishlistEntity) -> Observable<Bool>
    func removeWishlistedGames(gameId: Int)
    func checkIfWishlisted(gameId: Int) -> Observable<Bool>
}

class WishlistRealmLocalDataSource {
    let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> WishlistLocalDataSource = { realmDatabase in
        return WishlistRealmLocalDataSource(realm: realmDatabase)
    }
}

extension WishlistRealmLocalDataSource: WishlistLocalDataSource {
    func getWishlistedGames() -> Observable<[WishlistEntity]> {
        return Observable<[WishlistEntity]>.create { observer in
            if let realm = self.realm {
                let wishlistedGames = realm.objects(WishlistEntity.self)
                observer.onNext(Array(wishlistedGames))
                observer.onCompleted()
            } else {
                observer.onError(RealmError.readError)
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
