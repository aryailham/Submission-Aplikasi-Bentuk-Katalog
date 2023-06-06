//
//  WishlistRouter.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import UIKit

final class WishlistRouter {
    static func createModule() -> UINavigationController {
        let interactor = WishlistInjection().provideWishlist()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "wishlistViewController") as! WishlistViewController
        let presenter = WishlistDefaultPresenter(view: controller, interactor: interactor)
        controller.presenter = presenter
        
        return UINavigationController(rootViewController: controller)
    }
}
