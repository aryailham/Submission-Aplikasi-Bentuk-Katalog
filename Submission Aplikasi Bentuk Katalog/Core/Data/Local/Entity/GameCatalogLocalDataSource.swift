//
//  GameCatalogLocalDataSource.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 04/06/23.
//

import Foundation
import RxSwift
import RealmSwift

enum RealmError: Error {
    case readError
}


protocol GameCatalogLocalDataSource {
    func addData(from gameCatalog: [GameCatalogEntity]) -> Observable<Bool>
    func getData() -> Observable<[GameCatalogEntity]>
}

class GameCatalogDefaultLocalDataSource {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> GameCatalogLocalDataSource = { realmDatabase in
        return GameCatalogDefaultLocalDataSource(realm: realmDatabase)
    }
}

extension GameCatalogDefaultLocalDataSource: GameCatalogLocalDataSource {
    func addData(from gameCatalog: [GameCatalogEntity]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    if !gameCatalog.isEmpty {
                        try realm.write({
                            for game in gameCatalog {
                                realm.add(game, update: .all)
                            }
                        })
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                } catch let error {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
        
    }
    
    func getData() -> Observable<[GameCatalogEntity]> {
        return Observable<[GameCatalogEntity]>.create { observer in
            if let realm = self.realm {
                let gameCatalog: Results<GameCatalogEntity> = {
                    realm.objects(GameCatalogEntity.self)
                }()
                observer.onNext(gameCatalog.toArray(ofType: GameCatalogEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(RealmError.readError)
            }
            
            return Disposables.create()
        }
    }
}

extension Results {

  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }

}
