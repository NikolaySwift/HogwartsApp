//
//  Character.swift
//  HogwartsApp
//
//  Created by NikolayD on 09.08.2024.
//


struct HogwartsCharacter: Decodable {
    let name: String
    let alternateNames: [String]
    let species: String
    let gender: String
    let dateOfBirth: String?
    let wand: Wand
    let patronus: String
    let actor: String
    let image: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    
    var description: String {
        """
        Species: \(species)
        Gender: \(gender)
        Date of birth: \(dateOfBirth ?? "unknown")
        Patronus: \(patronus.isEmpty ? "unknown" : patronus)
        Alternate names: \(alternateNames.isEmpty ? "none" : alternateNames.formatted())
        Actor: \(actor)
        
        \(wand.description)
        """
    }
}

struct Wand: Decodable {
    let wood: String
    let core: String
    let length: Double?
    
    var description: String {
        """
        Wand was made from:
            - wood: \(wood.isEmpty ? "unknown" : wood)
            - core: \(core.isEmpty ? "unknown" : core).
        and its length: \(lengthToString)
        """
    }
    
    private var lengthToString: String {
        if let length {
            return String(format: "%.2f inches", length)
        } else {
            return "unknown"
        }
    }
}

