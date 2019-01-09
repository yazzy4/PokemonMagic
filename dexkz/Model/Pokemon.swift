//
//  Pokemon.swift
//  dexkz
//
//  Created by Pritesh Nadiadhara on 1/9/19.
//  Copyright © 2019 Pritesh Nadiadhara. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let cards: [PokemonInfo]
}

struct PokemonInfo: Codable {
    let imageUrl: String
    let imageUrlHiRes: String
    let attacks: [AttacksInfo]
    
}

struct AttacksInfo: Codable {
    let name: String
    let damage: String
    let text: String
}
