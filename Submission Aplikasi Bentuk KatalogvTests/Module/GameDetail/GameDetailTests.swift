//
//  GameDetailTests.swift
//  Submission Aplikasi Bentuk KatalogvTests
//
//  Created by Arya Moehammad Ilham on 12/06/23.
//

import XCTest
@testable import GameDetail

final class GameDetailTests: XCTestCase {
    func testGameDetailEmpty() throws {
        let interactor = GameDetailEmptyMockInteractor()
        let controller = UIStoryboard(name: "GameDetail", bundle: Bundle(identifier: "com.arya.GameDetail")).instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        let presenter = GameDetailDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()
        
        presenter.getGameDetail()
        XCTAssertNil(presenter.game)
    }
    
    func testGameDetailHasData() throws {
        let interactor = GameDetailHasDataMockInteractor()
        let controller = UIStoryboard(name: "GameDetail", bundle: Bundle(identifier: "com.arya.GameDetail")).instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        let presenter = GameDetailDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()
        
        presenter.getGameDetail()
        XCTAssertNotNil(presenter.game)
    }
    
    func testChangeGameStatusToWishlisted() throws {
        let interactor = GameDetailHasDataMockInteractor()
        interactor.isWishlisted = false
        let controller = UIStoryboard(name: "GameDetail", bundle: Bundle(identifier: "com.arya.GameDetail")).instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        let presenter = GameDetailDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()
        
        presenter.checkWishlistStatus()
        XCTAssertFalse(presenter.isWishlisted)
        XCTAssertFalse(presenter.oldWishlistValue)
        
        presenter.changeWishlistStatus()
        XCTAssertTrue(presenter.isWishlisted)
        XCTAssertFalse(presenter.oldWishlistValue)
    }
    
    func testChangeGameStatusToUnwishlisted() throws {
        let interactor = GameDetailHasDataMockInteractor()
        interactor.isWishlisted = true
        let controller = UIStoryboard(name: "GameDetail", bundle: Bundle(identifier: "com.arya.GameDetail")).instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        let presenter = GameDetailDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()
        
        presenter.checkWishlistStatus()
        XCTAssertTrue(presenter.isWishlisted)
        XCTAssertTrue(presenter.oldWishlistValue)
        
        presenter.changeWishlistStatus()
        XCTAssertFalse(presenter.isWishlisted)
        XCTAssertTrue(presenter.oldWishlistValue)
    }
    
    func testSetGameStatusToWishlisted() throws {
        let interactor = GameDetailHasDataMockInteractor()
        interactor.isWishlisted = false
        let controller = UIStoryboard(name: "GameDetail", bundle: Bundle(identifier: "com.arya.GameDetail")).instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        let presenter = GameDetailDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()
        
        presenter.checkWishlistStatus()
        presenter.changeWishlistStatus()
        presenter.setWishlistStatus()
        
        XCTAssertNil(controller.presentingViewController)
    }
    
    func testSetGameStatusToUnwishlisted() throws {
        let interactor = GameDetailHasDataMockInteractor()
        interactor.isWishlisted = true
        let controller = UIStoryboard(name: "GameDetail", bundle: Bundle(identifier: "com.arya.GameDetail")).instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        let presenter = GameDetailDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()
        
        presenter.checkWishlistStatus()
        presenter.changeWishlistStatus()
        presenter.setWishlistStatus()
        
        XCTAssertNil(controller.presentingViewController)
    }
}
