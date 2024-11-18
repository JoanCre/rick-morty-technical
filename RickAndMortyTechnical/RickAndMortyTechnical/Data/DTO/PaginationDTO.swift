//
//  PaginationDTO.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

struct PaginationDTO: Codable {
  var info: InfoDTO?
  var results: [CharacterDTO]?
}

struct InfoDTO: Codable {
  var count: Int?
  var pages: Int?
  var next: String?
}
