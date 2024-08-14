//
//  NetworkManager.swift
//  HogwartsApp
//
//  Created by NikolayD on 13.08.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    func fetch<T: Decodable>(
        _ type: T.Type,
        from url: URL,
        completion: @escaping(Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let dataFromServer = try decoder.decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(dataFromServer))
                }
            } catch {
                completion(.failure(.decodingError))
            }
            
        }.resume()
    }
    
    func fetchImage(
        from url: URL,
        completion: @escaping(Result<Data, NetworkError>) -> Void
    ) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    private init() {}
}
