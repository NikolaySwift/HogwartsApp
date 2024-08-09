//
//  Character.swift
//  HogwartsApp
//
//  Created by NikolayD on 09.08.2024.
//


struct HogwartsCharacter: Decodable {
    let name: String
    let alternate_names: [String]
    let species: String
    let gender: String
    let house: String
    let dateOfBirth: String?
    let yearOfBirth: Int?
    let wand: Wand
    let ancestry: String
    let patronus: String
    let actor: String
    let image: String
}

struct Wand: Decodable {
    let wood: String
    let core: String
    let length: Double?
}

