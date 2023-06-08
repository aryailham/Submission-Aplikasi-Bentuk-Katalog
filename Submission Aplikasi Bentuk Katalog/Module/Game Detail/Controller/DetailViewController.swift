//
//  DetailViewController.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit
import AlamofireImage

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
    var presenter: GameDetailPresenter?
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.setWishlistStatus()
    }
    
    @IBAction func wishlistTapped(_ sender: UIButton) {
        presenter?.changeWishlistStatus()
    }
    
    func setWishlisted() {
        DispatchQueue.main.async { [self] in
            wishlistImage.image = UIImage(systemName: "heart.fill")
            wishlistImage.tintColor = .red
        }
    }
    
    func setUnwishlisted() {
        DispatchQueue.main.async { [self] in
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
    
    func renderData() {
        guard let details = presenter?.game else {return}
        if let url = URL(string: details.backgroundImage ?? "") {
            self.gameImage.af.setImage(withURL: url)
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
    
}
