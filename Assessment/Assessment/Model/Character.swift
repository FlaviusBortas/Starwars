//
//  Character.swift
//  Assessment
//
//  Created by Flavius Bortas on 10/29/18.
//  Copyright © 2018 Flavius Bortas. All rights reserved.
//

import Foundation

class Films: Codable {
    let title: String
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
    let mass: String
    let gender: String
    let homeWorldURL: String
    let speciesURL: [String]
    let films: [String]
    
    // non related API property
    
    var allFilmsInvolvedIn = [String]()
    
    
    enum CodingKeys: String, CodingKey {
        case name, gender, mass, films
        case birthYear = "birth_year"
        case homeWorldURL = "homeworld"
        case speciesURL = "species"
    }
}
