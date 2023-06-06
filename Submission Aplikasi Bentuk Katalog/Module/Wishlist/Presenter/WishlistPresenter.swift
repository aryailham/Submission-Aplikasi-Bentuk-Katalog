//
//  WishlistPresenter.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import RxSwift

protocol WishlistPresenter {
    var wishlist: [GameModel] { get set }
    var numberOfWishlist: Int { get }
    func getWishlist()
    func goToDetailPage(index: Int)
}

class WishlistDefaultPresenter: WishlistPresenter {
    var view: WishlistViewController
    var router = WishlistRouter()
    var interactor: WishlistUseCase
    
    var wishlist: [GameModel] = []
    var disposeBag = DisposeBag()
    
    var numberOfWishlist: Int {
        get {
            return wishlist.count
        }
    }
    
    required init(view: WishlistViewController, interactor: WishlistUseCase) {
        self.view = view
        self.interactor = interactor
    }
    
    func getWishlist() {
        self.interactor.getWishlistedGames()
            .subscribe { wishlist in
                self.wishlist = wishlist
                DispatchQueue.main.async {
                    self.view.tableView.reloadData()
                }
            } onError: { error in
                
            }.disposed(by: disposeBag)
    }
    
    func goToDetailPage(index: Int) {
        
    }
}
