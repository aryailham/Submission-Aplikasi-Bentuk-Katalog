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

protocol GameDataFetcher {
    func getGameDetails(id: Int, completion: @escaping (Result<GameModel?, Error>) -> Void)
}

class GameCatalogRemoteDataSource {
    static let shared: GameCatalogRemoteDataSource = GameCatalogRemoteDataSource()
    
    private let API_KEY = "15bfabf3309c4dcfbfb75622a6daf2aa"
    private let GET_GAME_CATALOG = "https://api.rawg.io/api/games"
    private let GET_GAME_DETAILS = "https://api.rawg.io/api/games/%d"
        
    func getGameCatalog(completion: @escaping (Result<GameCatalogResponse?, Error>) -> ()) {
        var components = URLComponents(string: GET_GAME_CATALOG)!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: API_KEY)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.badURL))
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

extension GameCatalogRemoteDataSource: GameDataFetcher {
    func getGameDetails(id: Int, completion: @escaping (Result<GameModel?, Error>) -> Void) {
        var components = URLComponents(string: String(format: GET_GAME_DETAILS, id))!
        
        components.queryItems = [
            URLQueryItem(name: "key", value: API_KEY)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.badURL))
                return
            }
            
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                if 200...300 ~= response.statusCode {
                    do {
                        let decoded = try JSONDecoder().decode(GameDetailsResponse.self, from: data)
                        completion(.success(GameMapper.MapGameResponseToDomainModel(gameResponse: decoded)))
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
