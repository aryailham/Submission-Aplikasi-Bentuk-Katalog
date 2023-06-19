//
//  GameCatalogEmptyMockInteractor.swift
//  Submission Aplikasi Bentuk KatalogvTests
//
//  Created by Arya Moehammad Ilham on 12/06/23.
//

import Foundation
import RxSwift
@testable import Submission_Aplikasi_Bentuk_Katalog
@testable import Common

class GameCatalogEmptyMockInteractor: GameCatalogUseCase {
    func getgameCatalog() -> Observable<[GameModel]> {
        return Observable.empty()
    }
}

class GameCatalogHasDataMockInteractor: GameCatalogUseCase {
    func getgameCatalog() -> Observable<[GameModel]> {
        return Observable.just([GameModel()])
    }
}
