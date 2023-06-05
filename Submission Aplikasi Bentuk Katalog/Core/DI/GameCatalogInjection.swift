//
//  GameCatalogInjection.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation
import RealmSwift

final class GameCatalogInjection {
    private func provideGameCatalogRepository() -> GameCatalogRepository {
        let realm = try! Realm()
        
        let local = GameCatalogDefaultLocalDataSource.sharedInstance(realm)
        let remote = GameCatalogDefaultRemoteDataSource.shared
        
        return GameCatalogDefaultRepository.sharedInstance(local, remote)
    }
    
    func provideGameCatalog() -> GameCatalogUseCase {
        let repository = provideGameCatalogRepository()
        return GameCatalogDefaultProtocol(repository: repository)
    }
}
