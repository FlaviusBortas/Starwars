//
//  Character.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/29/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import Foundation

class Films: Codable {
    var characters: [String]
}

class HomeWorld: Codable {
    let name: String
}

class Species: Codable {
    let name: String
}

struct Character: Codable {
    let name: String
    let birthYear: String
    let gender: String
    let homeWorldURL: String
    let speciesURL: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, gender
        case birthYear = "birth_year"
        case homeWorldURL = "homeworld"
        case speciesURL = "species"
    }
}
