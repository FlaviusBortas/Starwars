//
//  Character.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/29/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import Foundation

class Character: Codable {
    let name: String
    let birthYear: String
    let gender: String
    let homeWorld: String
    let species: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, gender, species
        case birthYear = "birth_year"
        case homeWorld = "homeworld"
    }
    
}
