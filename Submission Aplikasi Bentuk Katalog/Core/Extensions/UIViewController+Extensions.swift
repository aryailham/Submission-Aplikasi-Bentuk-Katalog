//
//  UIViewController+Extensions.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit

extension UIViewController {
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
