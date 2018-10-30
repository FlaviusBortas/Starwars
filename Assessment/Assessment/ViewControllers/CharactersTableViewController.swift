//
//  CharactersTableViewController.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/29/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    var allCharacters = [Character]()
    var manager = NetworkManager()
    var selectedCharacter: Character?
    var allCharactersURL = "https://swapi.co/api/people/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.loadData(from: allCharactersURL) { (characters: Results) in
            for character in characters.results {
                self.allCharacters.append(character)
            }
            
            let queue = OperationQueue.main
            queue.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    

}

// MARK: - Table view data source
extension CharactersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCharacters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier , for: indexPath) as! CharacterTableViewCell
        
        cell.configure(with: allCharacters[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        selectedCharacter = allCharacters[indexPath.row]
        
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "CharacterDetails":
            guard let detailsVC = segue.destination as? CharacterDetailsViewController else { print("No Segue")
                return
            }
            
            detailsVC.character = selectedCharacter
        default:
            print("No success on switch case.")
        }
    }
}
