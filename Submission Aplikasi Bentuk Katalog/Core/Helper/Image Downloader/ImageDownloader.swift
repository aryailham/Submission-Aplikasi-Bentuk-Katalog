//
//  ImageDownloader.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    
    func downloadImage(url: URL) async throws -> UIImage? {
        async let imageData: Data = try Data(contentsOf: url)
        return UIImage(data: try await imageData)
    }
}
