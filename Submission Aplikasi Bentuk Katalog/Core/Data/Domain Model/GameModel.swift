//
//  GameModel.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 11/05/23.
//

import Foundation

struct GameModel {
    var id: Int?
    var name, released: String?
    var backgroundImage: String?
    var rating: Double?
    var ratingTop, metacritic: Int?
    var description: String?
    var tags: [TagsModel] = []

}


struct TagsModel: Codable {
    var id: Int?
    var name: String?
}
