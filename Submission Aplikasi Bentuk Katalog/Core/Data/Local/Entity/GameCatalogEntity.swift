//
//  GameCatalogEntity.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation
import RealmSwift

class GameCatalogEntity: Object {
    @Persisted var backgroundImage: String
    @Persisted var gameDescription: String
    @Persisted(primaryKey: true) var id: Int64
    @Persisted var metacritic: Int16
    @Persisted var name: String
    @Persisted var rating: Double
    @Persisted var ratingTop: Int16
    @Persisted var released: String
    @Persisted var tags: List<GameTagsEntity>
}
