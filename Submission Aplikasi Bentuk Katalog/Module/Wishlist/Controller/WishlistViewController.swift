//
//  WishlistViewController.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 11/05/23.
//

import UIKit

class WishlistViewController: UIViewController {
    // MARK: - IBOUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    private let local = WishlistCoreDataLocalDataSource()
    private var wishlist: [Wishlist] = []
    
    var presenter: WishlistPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getWishlist()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameCatalogTableViewCell.nib, forCellReuseIdentifier: GameCatalogTableViewCell.ID)
    }
}

extension WishlistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfWishlist ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameCatalogTableViewCell.ID, for: indexPath) as? GameCatalogTableViewCell else {
            return UITableViewCell()
        }
        
        if let wishlist = presenter?.wishlist[indexPath.row] {
            cell.setData(title: wishlist.name ?? "",
                         rating: wishlist.rating ?? 0.0,
                         releaseDate: wishlist.released ?? "",
                         image: wishlist.backgroundImage ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        vc.gameID = Int(wishlist[indexPath.row].id)
//        vc.gameFetcher = WishlistCoreDataLocalDataSource.shared
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
