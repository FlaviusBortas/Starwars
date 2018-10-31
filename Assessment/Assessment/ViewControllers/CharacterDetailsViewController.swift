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
    @IBOutlet weak var massLabel: UILabel!
    
    // MARK: - Properties
    
    private let manager = NetworkManager()
    private let queue = DispatchQueue.main
    var character: Character?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for film in character!.films {
            manager.loadData(from: film) { (film: Films) in
                
                self.character?.allFilmsInvolvedIn.append(film.title)
                
                print(self.character?.allFilmsInvolvedIn)
            }
            
        }
        
        
        
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
        massLabel.text = "Mass: \(character.mass)"
        
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
