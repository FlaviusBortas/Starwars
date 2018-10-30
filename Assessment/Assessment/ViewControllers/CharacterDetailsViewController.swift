//
//  CharacterDetailsViewController.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/30/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    //MARK: - UI Elements
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var homeWorldLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    // MARK: - Properties
    
    var manager = NetworkManager()
    var character: Character?
    let queue = DispatchQueue.main
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUILabels()
    }
    
    // MARK: - Methods
    
    func loadUILabels() {
        guard let character = character else {
            print("No Character")
            return
        }
        
        nameLabel.text = "Name: \(character.name)"
        birthYearLabel.text = "Birth Year: \(character.birthYear)"
        genderLabel.text = "Gender: \(character.gender)"
        
        manager.loadData(from: character.homeWorldURL) { (homeWorld: HomeWorld) in
            
            self.queue.async {
                self.homeWorldLabel.text = "Home World: \(homeWorld.name)"
            }
        }
        
        manager.loadData(from: character.speciesURL.first!) { (species: Species) in
            
            self.queue.async {
                self.speciesLabel.text = "Species: \(species.name)"
            }
        }
    }
}
