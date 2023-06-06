//
//  WishlistEntity.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 05/06/23.
//

import Foundation
import RealmSwift

class WishlistEntity: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var backgroundImage: String
    @Persisted var name: String
    @Persisted var rating: Double
    @Persisted var ratingTop: Int16
    @Persisted var metacritic: Int16
    @Persisted var released: String
    @Persisted var gameDescription: String
    @Persisted var tags: List<GameTagsEntity>
}
