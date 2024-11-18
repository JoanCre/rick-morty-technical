//
//  CharacterRepositoryProtocol.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func getCharactersAndNextPage(for page: Int) async throws -> Pagination
    func getCharactersAndNextPageWhenSearch(this name: String, for page: Int) async throws -> Pagination
}
