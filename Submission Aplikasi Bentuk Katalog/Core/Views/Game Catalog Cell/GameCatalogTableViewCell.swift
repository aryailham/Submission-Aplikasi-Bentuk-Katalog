//
//  GameCatalogTableViewCell.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit

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

    override func prepareForReuse() {
        gameImage.image = nil
        gameTitle.text = ""
        gameReleaseDate.text = ""
        gameRating.text = ""
    }
}
