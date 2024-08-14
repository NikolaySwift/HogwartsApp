//
//  CharacterCell.swift
//  HogwartsApp
//
//  Created by NikolayD on 13.08.2024.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var actorLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with character: HogwartsCharacter, and rowHeight: CGFloat) {
        nameLabel.text = character.name
        actorLabel.text = character.actor
        
        characterImageView.layer.cornerRadius = rowHeight / 2
        
        networkManager.fetchImage(from: URL(string: character.image)!) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let imageData):
                characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
