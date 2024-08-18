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

    init(characterDetails: [String: Any]) {
        name = characterDetails["name"] as? String ?? ""
        alternateNames = characterDetails["alternate_names"] as? [String] ?? []
        species = characterDetails["species"] as? String ?? ""
        gender = characterDetails["gender"] as? String ?? ""
        dateOfBirth = characterDetails["dateOfBirth"] as? String
        wand = Wand.getWand(from: characterDetails["wand"])
        patronus = characterDetails["patronus"] as? String ?? ""
        actor = characterDetails["actor"] as? String ?? ""
        image = characterDetails["image"] as? String ?? ""
        hogwartsStudent = characterDetails["hogwartsStudent"] as? Bool ?? false
        hogwartsStaff = characterDetails["hogwartsStaff"] as? Bool ?? false
    }
    
    static func getCharacters(from value: Any) -> [HogwartsCharacter] {
        guard let charactersDetails = value as? [[String: Any]] else { return [] }
        return charactersDetails.map { HogwartsCharacter(characterDetails: $0) }
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
    
    init(wood: String = "", core: String = "", length: Double? = nil) {
        self.wood = wood
        self.core = core
        self.length = length
    }
    
    init(wandDetails: [String: Any]) {
        wood = wandDetails["wood"] as? String ?? ""
        core = wandDetails["core"] as? String ?? ""
        length = wandDetails["length"] as? Double
    }
    
    static func getWand(from value: Any?) -> Wand {
        guard let wandDetails = value as? [String: Any] else {
            return Wand()
        }
        return Wand(wandDetails: wandDetails)
    }
    
    private var lengthToString: String {
        if let length {
            return String(format: "%.2f inches", length)
        } else {
            return "unknown"
        }
    }
}

