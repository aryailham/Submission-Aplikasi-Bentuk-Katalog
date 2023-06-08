//
//  GameDetailInjection.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 07/06/23.
//

import Foundation
import RealmSwift

final class GameDetailInjection {
    private func provideGameDetailRepository() -> GameDetailRepository {
        let realm = try! Realm()
        
        let local = GameDetailRealmLocalDataSource.sharedInstance(realm)
        let remote = GameDetailDefaultRemoteDataSource.shared
        
        return GameDetailDefaultRepository.sharedInstance(local, remote)
    }
    
    func provideGameDetail() -> GameDetailUseCase {
        let repository = provideGameDetailRepository()
        return GameDetailDefaultInteractor(repository: repository)
    }

}
