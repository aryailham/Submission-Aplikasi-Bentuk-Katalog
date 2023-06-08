//
//  GameDetailRemoteDataSource.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Moehammad Ilham on 06/06/23.
//

import Foundation
import RxSwift
import Alamofire

protocol GameDetailRemoteDataSource {
    func getGameDetails(id: Int) -> Observable<GameDetailsResponse>
}

class GameDetailDefaultRemoteDataSource {
    static let shared: GameDetailRemoteDataSource = GameDetailDefaultRemoteDataSource()
    
    private let API_KEY = "15bfabf3309c4dcfbfb75622a6daf2aa"
    private let GET_GAME_DETAILS = "https://api.rawg.io/api/games/%d"
}

extension GameDetailDefaultRemoteDataSource: GameDetailRemoteDataSource {
    func getGameDetails(id: Int) -> Observable<GameDetailsResponse> {
        return Observable<GameDetailsResponse>.create { observer in
            if let url = URL(string: String(format: self.GET_GAME_DETAILS, id)) {
                let parameters: Parameters = [
                    "key": self.API_KEY
                ]
                
                AF.request(url, parameters: parameters)
                    .validate()
                    .responseDecodable(of: GameDetailsResponse.self) { response in
                        switch response.result {
                        case .success(let gameDetailResponse):
                            observer.onNext(gameDetailResponse)
                            observer.onCompleted()
                        case .failure(let error):
                            observer.onError(error)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
