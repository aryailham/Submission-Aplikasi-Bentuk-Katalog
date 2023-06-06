//
//  WishlistInjection.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import RealmSwift

final class WishlistInjection {
    private func provideWishlistRepository() -> WishlistRepository {
        let realm = try! Realm()
        
        let local = WishlistRealmLocalDataSource.sharedInstance(realm)
        
        return WishlistDefaultRepository(local: local)
    }
    
    func provideWishlist() -> WishlistUseCase {
        let repository = provideWishlistRepository()
        return WishlistDefaultInteractor(repository: repository)
    }
}
