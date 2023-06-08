//
//  GameDetailRouter.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 08/06/23.
//

import Foundation
import UIKit

final class GameDetailRouter {
    static func createModule(gameId: Int) -> DetailViewController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        let interactor = GameDetailInjection.init().provideGameDetail()
        let presenter = GameDetailDefaultPresenter(view: controller, interactor: interactor)
        presenter.gameId = gameId
        controller.presenter = presenter
        
        return controller
    }
}
