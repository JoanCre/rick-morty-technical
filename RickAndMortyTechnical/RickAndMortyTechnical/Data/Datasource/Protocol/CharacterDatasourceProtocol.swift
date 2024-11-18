//
//  CharacterDatasourceProtocol.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

protocol CharacterDatasourceProtocol {
    func getCharactersAndNextPage(for page: Int) async throws -> PaginationDTO?
    func getCharactersAndNextPageWhenSearching(this name: String, for page: Int) async throws -> PaginationDTO?
}
