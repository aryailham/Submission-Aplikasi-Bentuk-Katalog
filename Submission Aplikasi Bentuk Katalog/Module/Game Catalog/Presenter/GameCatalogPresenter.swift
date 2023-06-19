//
//  GameCatalogPresenter.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation
import RxSwift
import Common

protocol GameCatalogPresenter {
    var gameCatalog: [GameModel] {get set}
    var numOfGames: Int { get }
    
    func getGameCatalog()
    func goToDetailPage(index: Int)
}

class GameCatalogDefaultPresenter: GameCatalogPresenter {
    private var view: GameCatalogViewController
    private var interactor: GameCatalogUseCase
    private var router = GameCatalogRouter()
    
    var gameCatalog: [GameModel] = []
    var numOfGames: Int {
        get {
            return gameCatalog.count
        }
    }
    private var disposeBag = DisposeBag()
    
    init(view: GameCatalogViewController, interactor: GameCatalogUseCase) {
        self.view = view
        self.interactor = interactor
    }
    
    func getGameCatalog() {
        interactor.getgameCatalog()
            .subscribe { gameCatalog in
                self.gameCatalog = gameCatalog
                DispatchQueue.main.async {
                    self.view.tableView.reloadData()
                }
            } onError: { error in
                print(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func goToDetailPage(index: Int) {
        if let id = gameCatalog[index].id {
            self.router.goToDetailGamePage(gameID: id, controller: view)
        }
    }
}
