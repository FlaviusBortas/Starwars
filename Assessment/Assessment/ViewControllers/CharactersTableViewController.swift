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
    var selectedCharacter: Character?
    var allCharactersURL = "https://swapi.co/api/people/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData(from: allCharactersURL) { (characters: Results) in
            for character in characters.results {
                self.allCharacters.append(character)
            }
            
            let queue = OperationQueue.main
            queue.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    func loadData<T: Decodable>(from urlString: String, completion: @escaping (T) -> ()) {
        // Create a configuration
        let configuration = URLSessionConfiguration.ephemeral
        
        // Create a session
        let session = URLSession(configuration: configuration)
        
        // Setup the url
        let url = URL(string: urlString)!
        
        // Create the task
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                
                completion(object)
                
            } catch {
                print("Error info: \(error)")
            }
        }
        task.resume()
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
        let selectedCharacterHomeWorldURL = allCharacters[indexPath.row].homeWorld
        guard let selectedCharacterSpeciesURL = allCharacters[indexPath.row].species.first else { return indexPath }
        
        loadData(from: selectedCharacterHomeWorldURL) { (homeWorld: HomeWorld) in
            self.selectedCharacter?.homeWorldName = homeWorld.name
        }
        
        loadData(from: selectedCharacterSpeciesURL) { (species: Species) in
            self.selectedCharacter?.speciesName = species.name
        }
        
        selectedCharacter = allCharacters[indexPath.row]
        
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
