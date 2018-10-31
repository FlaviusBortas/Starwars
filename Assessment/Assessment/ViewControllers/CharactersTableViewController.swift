//
//  CharactersTableViewController.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/29/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import UIKit

class CharactersTableViewController: UITableViewController {
    
    //MARK: - Properties
    
    var allCharacters = [Character]()
    var allFilms = [String]()
    var manager = NetworkManager()
    var selectedCharacter: Character?
    let queue = DispatchQueue.main
    var allCharactersURL = "https://swapi.co/api/films/2/"
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.loadData(from: allCharactersURL) { (films: Films) in
            for film in films.characters {
                
                self.manager.loadData(from: film) { (character: Character) in
                    print(character.films)
                    self.allCharacters.append(character)
                    
                    self.queue.async {
                        self.tableView.reloadData()
                    }
                }
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
