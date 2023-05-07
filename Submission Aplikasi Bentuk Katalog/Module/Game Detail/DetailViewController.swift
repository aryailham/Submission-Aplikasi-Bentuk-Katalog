//
//  DetailViewController.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - IBOUTLET
    @IBOutlet weak var gameImage: UIImageView!
    
    @IBOutlet weak var gameTitle: UILabel!
    
    @IBOutlet weak var generalCardView: UIView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ranking: UILabel!
    @IBOutlet weak var metacritic: UILabel!
    
    @IBOutlet weak var aboutCardView: UIView!
    @IBOutlet weak var about: UILabel!
    
    @IBOutlet weak var tagsCardView: UIView!
    @IBOutlet weak var tags: UILabel!
    
    // MARK: - VARIABLES
    var remote = GameCatalogRemoteDataSource()
    var gameID: Int?
    var gameDetails: GameDetailsResponse?
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getDetails()
    }
    
    private func setupView() {
        generalCardView.createAsCard()
        aboutCardView.createAsCard()
        tagsCardView.createAsCard()
    }
    
    private func renderData() {
        guard let details = gameDetails else {return}
        Task {
            let image = try await ImageDownloader.shared.downloadImage(url: URL(string: details.backgroundImage)!)
            self.gameImage.image = image
        }
        self.gameTitle.text = details.name
        self.rating.text = String(details.rating)
        self.ranking.text = String(details.ratingTop)
        self.metacritic.text = String(details.metacritic)
        self.about.attributedText = details.description.htmlToAttributedString
        
        self.tags.text = ""
        details.tags.forEach { tag in
            self.tags.text?.append(tag.name)
            if tag.id != details.tags.last?.id {
                self.tags.text?.append(", ")
            }
        }
    }
    
    private func getDetails() {
        guard let id = gameID else {return}
        remote.getGameDetails(id: id) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                self.gameDetails = success
                DispatchQueue.main.async {
                    self.renderData()
                }
            case .failure(let failure):
                self.showErrorMessage(message: failure.localizedDescription)
            }
        }
    }
}
