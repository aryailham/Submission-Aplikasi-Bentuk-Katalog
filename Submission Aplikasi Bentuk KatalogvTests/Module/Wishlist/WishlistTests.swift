//
//  WishlistTests.swift
//  Submission Aplikasi Bentuk KatalogvTests
//
//  Created by Arya Moehammad Ilham on 15/06/23.
//

import XCTest
import RxSwift
@testable import Submission_Aplikasi_Bentuk_Katalog

final class WishlistTests: XCTestCase {
    func testWishlistEmpty() throws {
        let interactor = WishlistEmptyMockInteractor()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "wishlistViewController") as! WishlistViewController
        let presenter = WishlistDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()

        presenter.getWishlist()
        XCTAssertEqual(presenter.wishlist.count, 0)
    }
    
    func testWishlistHasData() throws {
        let interactor = WishlistHasDataMockInteractor()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "wishlistViewController") as! WishlistViewController
        let presenter = WishlistDefaultPresenter(view: controller, interactor: interactor)
        controller.loadView()
        
        presenter.getWishlist()
        XCTAssertNotEqual(presenter.wishlist.count, 0)
    }
}
