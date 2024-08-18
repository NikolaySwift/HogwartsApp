//
//  CharactersListViewController.swift
//  HogwartsApp
//
//  Created by NikolayD on 13.08.2024.
//

import UIKit

final class CharactersListViewController: UITableViewController {
    
    var houseName: String!
    
    private let networkManager = NetworkManager.shared
    private var characters: [HogwartsCharacter] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
        navigationItem.title = houseName == House.staff.rawValue
            ? houseName + " staff"
            : houseName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        detailsVC.character = characters[indexPath.row]
    }

    // MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterCell else { return UITableViewCell() }
        
        cell.configure(with: characters[indexPath.row])
        
        return cell
    }
    
    func fetchCharacters(from house: House) {
        networkManager.fetchCharacters(from: house.url) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let characters):
                    self.characters = characters.filter{ !$0.image.isEmpty }
                    tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
}
