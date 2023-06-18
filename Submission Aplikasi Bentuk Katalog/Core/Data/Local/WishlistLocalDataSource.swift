//
//  WishlistDefaultLocalDataSource.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import RxSwift
import RealmSwift
import Common

protocol WishlistLocalDataSource {
    func getWishlistedGames() -> Observable<[WishlistEntity]>
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
}
