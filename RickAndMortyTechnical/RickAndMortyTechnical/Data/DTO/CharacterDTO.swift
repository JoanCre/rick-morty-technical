//
//  CharacterDTO.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

struct CharacterDTO: Codable {
    var image: String
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var location: CharacterPlaceDTO
    var origin: CharacterPlaceDTO
}

struct CharacterPlaceDTO: Codable {
    var name: String
    var url: String
}
