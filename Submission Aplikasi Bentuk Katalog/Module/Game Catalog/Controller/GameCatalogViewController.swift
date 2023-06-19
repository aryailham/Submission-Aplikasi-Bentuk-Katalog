//
//  ViewController.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit
import Common

class GameCatalogViewController: UIViewController {
    // MARK: IBOUTLET
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VARIABLES
    var presenter: GameCatalogPresenter?
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.getGameCatalog()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(GameCatalogTableViewCell.nib, forCellReuseIdentifier: GameCatalogTableViewCell.ID)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension GameCatalogViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numOfGames ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameCatalogTableViewCell.ID, for: indexPath) as? GameCatalogTableViewCell else {
            return UITableViewCell()
        }
        if let game = presenter?.gameCatalog[indexPath.row] {
            cell.setData(title: game.name ?? "",
                         rating: game.rating ?? 0.0,
                         releaseDate: game.released ?? "",
                         image: game.backgroundImage ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.goToDetailPage(index: indexPath.row)
    }
}
