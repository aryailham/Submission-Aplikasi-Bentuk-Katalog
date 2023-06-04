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
    
    private let local = WishlistDefaultLocalDataSource()
    private var wishlist: [Wishlist] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    private func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameCatalogTableViewCell.nib, forCellReuseIdentifier: GameCatalogTableViewCell.ID)
    }
    
    private func getData() {
        local.getWishlistedGames { wishlist in
            self.wishlist = wishlist
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension WishlistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.wishlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameCatalogTableViewCell.ID, for: indexPath) as? GameCatalogTableViewCell else {
            return UITableViewCell()
        }
        
        let wishlist = wishlist[indexPath.row]
        cell.setData(title: wishlist.name ?? "", rating: wishlist.rating, releaseDate: wishlist.released ?? "", image: wishlist.backgroundImage ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.gameID = Int(wishlist[indexPath.row].id)
        vc.gameFetcher = WishlistDefaultLocalDataSource.shared
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
