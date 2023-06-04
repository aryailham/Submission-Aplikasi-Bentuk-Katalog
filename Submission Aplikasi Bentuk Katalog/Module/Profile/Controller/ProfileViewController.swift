//
//  ProfileViewController.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.profileImage.layer.cornerRadius = 75
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

}
