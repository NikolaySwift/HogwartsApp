//
//  AlamofireNetworkManager.swift
//  HogwartsApp
//
//  Created by NikolayD on 18.08.2024.
//

import Foundation
import Alamofire

final class AlamofireNetworkManager {
    static let shared = AlamofireNetworkManager()
    
    func fetchCharacters(
        from url: URL,
        completion: @escaping(Result<[HogwartsCharacter], AFError>) -> Void
    ) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let characters: [HogwartsCharacter] = HogwartsCharacter.getCharacters(from: value)
                    completion(.success(characters))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(
        from url: String,
        completion: @escaping(Result<Data, AFError>) -> Void
    ){
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    private init() {}
}
