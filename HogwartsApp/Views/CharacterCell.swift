//
//  CharacterCell.swift
//  HogwartsApp
//
//  Created by NikolayD on 13.08.2024.
//

import UIKit

final class CharacterCell: UITableViewCell {
    
    @IBOutlet var characterImageView: UIImageView! {
        didSet {
            characterImageView.contentMode = .scaleToFill
            characterImageView.clipsToBounds = true
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var actorLabel: UILabel!
    
    private let networkManager = NetworkManager.shared
    
    func configure(with character: HogwartsCharacter) {
        nameLabel.text = character.name
        actorLabel.text = character.actor
        let activityIndicator = showSpinner(in: characterImageView)
        
        networkManager.fetchImage(from: URL(string: character.image)!) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let imageData):
                /*
                 в ячейке такая картинка получилась из-за content mode = aspect fill
                 если использовать aspect fit, то, так как картинки прямоугольной формы
                 и разных размеров, слева и справа остаются пустые зоны и скругление углов
                 не видно или видно частично
                 scale to fill тоже не полностью решает задачу, картинка выглядит нечеткой
                 Есть ли решения данной проблемы средствами swift и uikit?
                 */
                characterImageView.image = UIImage(data: imageData)
                activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
}
