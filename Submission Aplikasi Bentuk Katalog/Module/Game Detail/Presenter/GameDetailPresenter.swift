//
//  GameDetailPresenter.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 07/06/23.
//

import Foundation
import RxSwift

protocol GameDetailPresenter {
    var game: GameModel? {get set}
    func viewDidLoad()
    func getGameDetail()
    func checkWishlistStatus()
    func addGameToWishlist()
    func removeGameFromWishlist()
    func changeWishlistStatus()
    func setWishlistStatus()
}

class GameDetailDefaultPresenter: GameDetailPresenter {
    let view: DetailViewController
    let interactor: GameDetailUseCase
    let router = GameDetailRouter()
    
    let disposeBag = DisposeBag()
    var gameId = 0
    var game: GameModel?
    var oldWishlistValue: Bool = false
    var isWishlisted: Bool = false

    init(view: DetailViewController, interactor: GameDetailUseCase) {
        self.view = view
        self.interactor = interactor
    }
}

extension GameDetailDefaultPresenter {
    func viewDidLoad() {
        self.getGameDetail()
        self.checkWishlistStatus()
    }
    
    func checkWishlistStatus() {
        interactor.checkIfWishlisted(gameId: self.gameId)
            .subscribe { isWishlisted in
                self.isWishlisted = isWishlisted
                self.oldWishlistValue = isWishlisted
                switch isWishlisted {
                case true:
                    self.view.setWishlisted()
                case false:
                    self.view.setUnwishlisted()
                }
            } onError: { error in
                self.view.showErrorMessage(message: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func getGameDetail() {
        interactor.getGameDetailData(gameId: self.gameId)
            .subscribe { game in
                self.game = game
                DispatchQueue.main.async {
                    self.view.renderData()
                }
            } onError: { error in
                self.view.showErrorMessage(message: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func addGameToWishlist() {
        guard let game = self.game else {return}
        interactor.storeNewWishlistedGames(wishlistedGame: game)
            .subscribe(onError: { error in
                self.view.showErrorMessage(message: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func removeGameFromWishlist() {
        interactor.removeWishlistedGames(gameId: self.gameId)
            .subscribe(onError: { error in
                self.view.showErrorMessage(message: error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func changeWishlistStatus() {
        switch isWishlisted {
            case true:
            self.isWishlisted = false
            view.setUnwishlisted()
            case false:
            self.isWishlisted = true
            view.setWishlisted()
        }
    }
    
    func setWishlistStatus() {
        if oldWishlistValue != isWishlisted {
            switch isWishlisted {
            case true:
                self.addGameToWishlist()
            case false:
                self.removeGameFromWishlist()
            }
        }
    }
}
