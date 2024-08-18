//
//  NetworkManager.swift
//  HogwartsApp
//
//  Created by NikolayD on 13.08.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData(String)
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchCharacters(
        from url: URL,
        completion: @escaping(Result<[HogwartsCharacter], NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData(error?.localizedDescription ?? "No error description")))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let characters = try decoder.decode([HogwartsCharacter].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(characters))
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
                completion(.failure(.noData("No error description")))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    private init() {}
}
