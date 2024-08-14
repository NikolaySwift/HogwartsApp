//
//  ViewController.swift
//  HogwartsApp
//
//  Created by NikolayD on 09.08.2024.
//

import UIKit

final class MainViewController: UICollectionViewController {
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
        
        cell.configure(with: categories[indexPath.item])
        
        return cell
    }
    
    // MARK: -
    override func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        performSegue(withIdentifier: "showCharacters", sender: categories[indexPath.item])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let charactersListVC = segue.destination as? CharactersListViewController else {
            return
        }
        guard let house = sender as? House else { return }
        charactersListVC.fetchCharacters(fromHouse: house)
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

