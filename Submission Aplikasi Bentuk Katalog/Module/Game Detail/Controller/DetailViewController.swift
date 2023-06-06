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
    
    @IBOutlet weak var releaseDateView: UIView!
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var gameTitle: UILabel!
    
    @IBOutlet weak var generalCardView: UIView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ranking: UILabel!
    @IBOutlet weak var metacritic: UILabel!
    
    @IBOutlet weak var aboutCardView: UIView!
    @IBOutlet weak var about: UILabel!
    
    @IBOutlet weak var tagsCardView: UIView!
    @IBOutlet weak var tags: UILabel!
    
    @IBOutlet weak var wishlistImage: UIImageView!
    @IBOutlet weak var wishlistView: UIView!
    
    // MARK: - VARIABLES
    var gameFetcher: GameCatalogDetailRemoteDataSource?
    var local = WishlistCoreDataLocalDataSource.shared
    var gameID: Int?
    var gameDetails: GameModel?
    
    var oldWishlistValue: Bool = false
    var isWishlisted: Bool = false
    
    let wishlistThread = DispatchQueue(label: "wishlistThread", attributes: .concurrent)
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getDetails()
        if let id = gameID {
            wishlistThread.async(flags: .barrier) { [self] in
                oldWishlistValue = local.checkIfWishlisted(gameID: id)
                switch oldWishlistValue {
                case true:
                    setWishlisted()
                case false:
                    setUnwishlisted()
                }
                
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if oldWishlistValue != isWishlisted {
            wishlistThread.sync { [self] in
                switch isWishlisted {
                    case true:
                    guard let game = gameDetails else { return }
                    local.storeNewWishlist(game: game)
                    case false:
                    guard let id = gameDetails?.id else { return }
                    local.removeWishlistedGame(gameID: id)
                    break
                }

            }
        }
    }
    
    @IBAction func wishlistTapped(_ sender: UIButton) {
        switch isWishlisted {
            case true:
            setUnwishlisted()
            case false:
            setWishlisted()
        }
    }
    
    private func setWishlisted() {
        DispatchQueue.main.async { [self] in
            self.isWishlisted = true
            wishlistImage.image = UIImage(systemName: "heart.fill")
            wishlistImage.tintColor = .red
        }
    }
    
    private func setUnwishlisted() {
        DispatchQueue.main.async { [self] in
            self.isWishlisted = false
            wishlistImage.image = UIImage(systemName: "heart")
            wishlistImage.tintColor = .gray
        }
    }
    
    private func setupView() {
        generalCardView.createAsCard()
        generalCardView.backgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
        aboutCardView.createAsCard()
        aboutCardView.backgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
        tagsCardView.createAsCard()
        tagsCardView.backgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
        releaseDateView.createAsCard()
        releaseDateView.backgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
        
        wishlistView.layer.cornerRadius = wishlistView.bounds.height / 2
    }
    
    private func renderData() {
        guard let details = gameDetails else {return}
        Task {
            let image = try await ImageDownloader.shared.downloadImage(url: URL(string: details.backgroundImage ?? "")!)
            self.gameImage.image = image
        }
        self.releaseDate.text = "Released: \(details.released ?? "Not Yet")"
        self.gameTitle.text = details.name
        self.rating.text = String(details.rating ?? 0)
        self.ranking.text = String(details.ratingTop ?? 0)
        self.metacritic.text = String(details.metacritic ?? 0)
        if let description = details.description {
            self.about.attributedText = description.htmlToAttributedString
        }
        
        self.tags.text = ""
        details.tags.forEach { tag in
            self.tags.text?.append(tag.name ?? "")
            if tag.id != details.tags.last?.id {
                self.tags.text?.append(", ")
            }
        }
    }
    
    private func getDetails() {
        guard let id = gameID else {return}
        gameFetcher?.getGameDetails(id: id) { [weak self] result in
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
