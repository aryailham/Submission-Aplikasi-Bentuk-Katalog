//
//  GameCatalogTests.swift
//  Submission Aplikasi Bentuk KatalogvTests
//
//  Created by Arya Moehammad Ilham on 12/06/23.
//

import XCTest
@testable import Submission_Aplikasi_Bentuk_Katalog

final class GameCatalogTests: XCTestCase {
    func testGameCatalogEmpty() throws {
        let interactor = GameCatalogEmptyMockInteractor()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameCatalogViewController") as! GameCatalogViewController
        let presenter = GameCatalogDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()

        presenter.getGameCatalog()
        XCTAssertEqual(presenter.gameCatalog.count, 0)
    }
    
    func testGameCatalogHasData() throws {
        let interactor = GameCatalogHasDataMockInteractor()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameCatalogViewController") as! GameCatalogViewController
        let presenter = GameCatalogDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()
        
        presenter.getGameCatalog()
        XCTAssertNotEqual(presenter.gameCatalog.count, 0)
    }
}
