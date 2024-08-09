//
//  ViewController.swift
//  HogwartsApp
//
//  Created by NikolayD on 09.08.2024.
//

import UIKit

class MainViewController: UICollectionViewController {
    private let categories = DataStore.shared.categories

    // MARK: - UICollectionViewDataSource
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        DataStore.shared.categories.count
    }
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "categoryCell",
            for: indexPath
        )
        guard let cell = cell as? CategoryCell else {
            return UICollectionViewCell()
        }
        
        cell.categoryLabel.text = categories[indexPath.item].rawValue
        cell.backgroundColor = switch categories[indexPath.item] {
        case .gryffindor: .systemRed
        case .slytherin: .systemGreen
        case .hufflepuff: .systemBlue
        case .ravenclaw: .systemYellow
        }
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    // MARK: -
    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        fetchCharacters(fromHouse: categories[indexPath.item])
    }
    
    private func fetchCharacters(fromHouse house: House) {
        URLSession.shared.dataTask(with: house.url) { data, response, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let characters = try JSONDecoder().decode(
                    [HogwartsCharacter].self,
                    from: data
                )
                print(characters.first ?? "No character")
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

