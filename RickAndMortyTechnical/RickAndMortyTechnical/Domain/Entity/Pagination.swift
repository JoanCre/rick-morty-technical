//
//  Pagination.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

struct Pagination {
  var hasNextPage: Bool
  var characters: [Character]

  init(dto: PaginationDTO) {
    hasNextPage = dto.info?.next != nil
    characters = dto.results?.map({ Character(dto: $0) }) ?? []
  }
}
