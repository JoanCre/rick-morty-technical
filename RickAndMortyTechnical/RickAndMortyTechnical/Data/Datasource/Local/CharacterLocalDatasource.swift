//
//  CharacterLocalDatasource.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

final class CharacterLocalDatasource  {
    let localManager: LocalManagerProtocol

    init(cacheManager: LocalManagerProtocol) {
        self.localManager = cacheManager
    }
}

extension CharacterLocalDatasource: CharacterDatasourceProtocol {
    func getCharactersAndNextPage(for page: Int) async throws -> PaginationDTO? {
        return localManager.get(PaginationDTO.self, forKey: "\(page)")
    }

    func getCharactersAndNextPageWhenSearching(this name: String, for page: Int) async throws -> PaginationDTO? {
        return localManager.get(PaginationDTO.self, forKey: "\(name) + \(page)")
    }
}
