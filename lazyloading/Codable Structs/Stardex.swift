//
//  Stardex.swift
//  lazyloading
//
//  Created by Chinedu Uche on 30/10/2023.
//

import Foundation

struct Stardex: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Starwars]
    
}

struct Starwars: Codable{
    let name: String
    let height: String
    let mass: String
    let hair_color: String
    let skin_color: String
    let eye_color: String
    let birth_year: String
    let gender: String
    let url: String
}

