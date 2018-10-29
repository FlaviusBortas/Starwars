//
//  CharacterTableViewCell.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/29/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterNameLabel: UILabel!
    
    static let identifier = "character"
    
    func configure(with character: Character) {
        characterNameLabel.text = character.name
    }
}
