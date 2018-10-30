//
//  CharacterDetailsViewController.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/30/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var homeWorldLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    
    var manager = NetworkManager()
    var character: Character?
    let queue = OperationQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUILabels()
    }
    
    func loadUILabels() {
        guard let character = character else {
            print("No Character")
            return
        }
        
        nameLabel.text = character.name
        birthYearLabel.text = character.birthYear
        genderLabel.text = character.gender
        
        manager.loadData(from: character.homeWorldURL) { (homeWorld: HomeWorld) in
            
            self.queue.addOperation {
                self.homeWorldLabel.text = homeWorld.name
            }
        }
        
        manager.loadData(from: character.speciesURL.first!) { (species: Species) in
            
            self.queue.addOperation {
                self.speciesLabel.text = species.name
            }
        }
    }
}
