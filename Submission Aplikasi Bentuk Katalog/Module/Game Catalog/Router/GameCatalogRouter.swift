//
//  GameCatalogRouter.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import UIKit

class GameCatalogRouter {
    static func createModule() -> UINavigationController {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameCatalogViewController") as! GameCatalogViewController
        let interactor = GameCatalogInjection.init().provideGameCatalog()
        let presenter = GameCatalogDefaultPresenter(view: controller, interactor: interactor)
        controller.presenter = presenter
        
        return UINavigationController(rootViewController: controller)
    }
    
    func goToDetailGamePage(gameID: Int, controller: UIViewController) {
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //        vc.gameID = gameCatalog[indexPath.row].id
        //        vc.gameFetcher = GameCatalogDefaultRemoteDataSource.shared
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
}
