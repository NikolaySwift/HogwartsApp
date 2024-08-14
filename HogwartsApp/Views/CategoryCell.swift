//
//  CategoryCell.swift
//  HogwartsApp
//
//  Created by NikolayD on 09.08.2024.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    @IBOutlet var houseImageView: UIImageView!
    
    func configure(with house: House) {
        let houseImage = UIImage(named: house.rawValue)
        houseImageView.image = houseImage
        layer.cornerRadius = 20
        if house == .staff {
            houseImageView.contentMode = .scaleAspectFit
        }
    }
}
