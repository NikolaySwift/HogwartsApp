//
//  DetailsViewController.swift
//  HogwartsApp
//
//  Created by NikolayD on 13.08.2024.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var character: HogwartsCharacter!
    
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = character.name
        descriptionLabel.text = character.description
        
        activityIndicator.style = .large
        activityIndicator.center = characterImageView.center
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        if !character.image.isEmpty {
            networkManager.fetchImage(from: URL(string: character.image)!) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let imageData):
                    characterImageView.image = UIImage(data: imageData)
                    activityIndicator.stopAnimating()
                case .failure(let error):
                    switch error {
                    case .noData(let message):
                        print(error, message)
                    default:
                        print(error)
                    }
                }
            }
        }
    }
}
