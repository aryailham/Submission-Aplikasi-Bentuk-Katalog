//
//  UIView+Extensions.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit

extension UIView {
    func createAsCard(cornerRadius: Double = 16.0, borderWidth: Double = 1.0, borderColor: UIColor = UIColor.gray) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = borderColor.cgColor
    }
}
