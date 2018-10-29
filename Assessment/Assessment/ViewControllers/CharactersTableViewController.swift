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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCharacters()
    }
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCharacters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier , for: indexPath) as! CharacterTableViewCell
        
        cell.configure(with: allCharacters[indexPath.row])

        return cell
    }


}

extension CharactersTableViewController {
    
    func loadCharacters() {

        // Create a configuration
        
        let configuration = URLSessionConfiguration.ephemeral
        
        // Create a session
        
        let session = URLSession(configuration: configuration)
        
        // Setup the url
        let url = URL(string: "https://swapi.co/api/people/")!
        
        // Create the task
        
        let task = session.dataTask(with: url) {
            
            (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode(Results.self, from: data)
                
                for character in characters.results {
//                    print(character)
                    self.allCharacters.append(character)
                }
                

                let queue = OperationQueue.main
                queue.addOperation {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error info: \(error)")
            }
        }
        task.resume()
    }
}
