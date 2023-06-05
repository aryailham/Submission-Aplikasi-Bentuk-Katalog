//
//  GameCatalogTableViewCell.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit
import AlamofireImage

class GameCatalogTableViewCell: UITableViewCell {
    // MARK: - NIB
    static let ID = "GameCatalogTableViewCell"
    
    static let nib: UINib? = {
        return UINib(nibName: "GameCatalogTableViewCell", bundle: nil)
    }()
    
    // MARK: - IBOUTLET
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameReleaseDate: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    
    // MARK: - VARIABLES
    
    // MARK: - FUNCTIONS
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    private func setupView() {
        containerView.createAsCard()
    }
    
    func setData(title: String, rating: Double, releaseDate: String, image: String) {
        gameTitle.text = title
        gameRating.text = "Rating: \(rating)"
        gameReleaseDate.text = "Released: \(releaseDate)"
        if let url = URL(string: image) {
            DispatchQueue.main.async {
                self.gameImage.af.setImage(withURL: url)
            }
        }
    }
    
    override func prepareForReuse() {
        self.gameImage.image = nil
        self.gameTitle.text = ""
        self.gameRating.text = ""
        self.gameReleaseDate.text = ""
    }
}
