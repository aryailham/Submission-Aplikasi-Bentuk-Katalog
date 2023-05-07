//
//  GameCatalogRemoteDataSource.swift
//  Submission Aplikasi Bentuk Katalog
//
//  Created by Arya Ilham on 07/05/23.
//

import Foundation
import Network

enum NetworkError: Error {
    case badURL
    case decodeError
}

class GameCatalogRemoteDataSource {
    static let shared: GameCatalogRemoteDataSource = GameCatalogRemoteDataSource()
    
    private let API_KEY = "15bfabf3309c4dcfbfb75622a6daf2aa"
    private let GET_GAME_CATALOG = "https://api.rawg.io/api/games"
    
    func getGameCatalog(completion: @escaping (Result<GameCatalogResponse?, Error>) -> ()) {
        var components = URLComponents(string: GET_GAME_CATALOG)!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: API_KEY)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                if 200...300 ~= response.statusCode {
                    do {
                        let decoded = try JSONDecoder().decode(GameCatalogResponse.self, from: data)
                        completion(.success(decoded))
                    } catch {
                        completion(.failure(NetworkError.decodeError))
                    }
                } else {
                    completion(.failure(NetworkError.badURL))
                }
            }
        }
        
        session.resume()
    }
}
