//
//  DataStore.swift
//  HogwartsApp
//
//  Created by NikolayD on 09.08.2024.
//

import Foundation

enum House: String, CaseIterable {
    case gryffindor = "Griffindor"
    case slytherin = "Slytherin"
    case hufflepuff = "Hufflepuff"
    case ravenclaw = "Ravenclaw"
    
    var url: URL {
        switch self {
        case .gryffindor:
            return URL(string: "https://hp-api.herokuapp.com/api/characters/house/gryffindor")!
        case .slytherin:
            return URL(string: "https://hp-api.herokuapp.com/api/characters/house/slytherin")!
        case .hufflepuff:
            return URL(string: "https://hp-api.herokuapp.com/api/characters/house/hufflepuff")!
        case .ravenclaw:
            return URL(string: "https://hp-api.herokuapp.com/api/characters/house/ravenclaw")!
        }
    }
}

final class DataStore {
    static let shared = DataStore()
    
    var categories: [House] {
        House.allCases
    }
    
    private init() {}
}
