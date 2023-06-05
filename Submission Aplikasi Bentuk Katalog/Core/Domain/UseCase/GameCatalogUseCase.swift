//
//  GameCatalogUseCase.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation
import RxSwift

protocol GameCatalogUseCase {
    func getgameCatalog() -> Observable<[GameModel]>
}

class GameCatalogDefaultProtocol: GameCatalogUseCase {
    private let repository: GameCatalogRepository
    
    init(repository: GameCatalogRepository) {
        self.repository = repository
    }
    
    func getgameCatalog() -> Observable<[GameModel]> {
        return repository.getGameCatalog()
    }
}
