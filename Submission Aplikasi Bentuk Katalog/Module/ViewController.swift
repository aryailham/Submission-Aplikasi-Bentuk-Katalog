//
//  ViewController.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit

class ViewController: UIViewController {
    // MARK: IBOUTLET
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - VARIABLES
    private let remoteDataSource = GameCatalogRemoteDataSource()
    private var gameCatalog: [GameData] = []
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }
    
    private func setupView() {
        tableView.register(GameCatalogTableViewCell.nib, forCellReuseIdentifier: GameCatalogTableViewCell.ID)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func getData() {
        remoteDataSource.getGameCatalog { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let gameCatalog):
                if let gameCatalog = gameCatalog {
                    self.gameCatalog = gameCatalog.results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let failure):
                self.showErrorMessage(message: failure.localizedDescription)
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameCatalog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameCatalogTableViewCell.ID, for: indexPath) as? GameCatalogTableViewCell else {
            return UITableViewCell()
        }
        let game = gameCatalog[indexPath.row]
        
        cell.gameTitle.text = game.name
        cell.gameRating.text = "Rating: \(game.rating)"
        cell.gameReleaseDate.text = "Released: \(game.released)"
        Task {
            cell.gameImage.image = try await ImageDownloader.shared.downloadImage(url: URL(string: "\(game.backgroundImage)")!)

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
