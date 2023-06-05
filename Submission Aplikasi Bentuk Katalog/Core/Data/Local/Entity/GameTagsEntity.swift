//
//  GameTagsEntity.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation
import RealmSwift

class GameTagsEntity: Object {
    @Persisted(primaryKey: true) var id: Int64
    @Persisted var name: String
}
