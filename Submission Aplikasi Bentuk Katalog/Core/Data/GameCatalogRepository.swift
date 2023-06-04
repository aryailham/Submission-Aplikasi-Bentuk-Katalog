//
//  GameCatalogRepository.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation

protocol GameCatalogRepository {
    func getGameCatalog(completion: @escaping (Result<GameCatalogResponse?, Error>) -> ())
}

class GameCatalogDefaultRepository {
    private var remote: GameCatalogRemoteDataSource?
}

extension GameCatalogDefaultRepository: GameCatalogRepository {
    func getGameCatalog(completion: @escaping (Result<GameCatalogResponse?, Error>) -> ()) {
        
    }
}
