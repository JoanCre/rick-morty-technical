//
//  CharacterRepository.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

final class CharacterRepository {
    private let localManager: LocalManagerProtocol
    private let localDatasource: CharacterDatasourceProtocol
    private let networkDatasource: CharacterDatasourceProtocol

    init(cacheManager: LocalManagerProtocol,
         localDatasource: CharacterDatasourceProtocol,
         networkDatasource: CharacterDatasourceProtocol) {
        self.localManager = cacheManager
        self.localDatasource = localDatasource
        self.networkDatasource = networkDatasource
    }
}

extension CharacterRepository: CharacterRepositoryProtocol {
    func getCharactersAndNextPage(for page: Int) async throws -> Pagination {
        if let localPagination = try await localDatasource.getCharactersAndNextPage(for: page) {
            return Pagination(dto: localPagination)
        }

        guard let networkPagination = try await networkDatasource.getCharactersAndNextPage(for: page) else {
            throw NetworkError.invalidData
        }
        localManager.set(networkPagination, forKey: "\(page)")
        return Pagination(dto: networkPagination)
    }

    func getCharactersAndNextPageWhenSearch(this name: String, for page: Int) async throws -> Pagination {
        if let localPagination = try await localDatasource.getCharactersAndNextPageWhenSearching(this: name, for: page) {
            return Pagination(dto: localPagination)
        }

        guard let networkPagination = try await networkDatasource.getCharactersAndNextPageWhenSearching(this: name, for: page) else {
            throw NetworkError.invalidData
        }
        localManager.set(networkPagination, forKey: "\(name) + \(page)")
        return Pagination(dto: networkPagination)
    }
}
