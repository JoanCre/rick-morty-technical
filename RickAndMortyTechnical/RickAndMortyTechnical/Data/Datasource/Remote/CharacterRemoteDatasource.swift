//
//  CharacterRemoteDatasource.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

final class CharactersNetworkDatasource  {
    let remoteManager: RemoteManagerProtocol

    init(networkManager: RemoteManagerProtocol) {
        self.remoteManager = networkManager
    }
}

extension CharactersNetworkDatasource: CharacterDatasourceProtocol {

    func getCharactersAndNextPage(for page: Int) async throws -> PaginationDTO? {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)") else {
            throw NetworkError.invalidURL
        }
        return try await remoteManager.fetchData(from: url, responseType: PaginationDTO.self)
    }

    func getCharactersAndNextPageWhenSearching(this name: String, for page: Int) async throws -> PaginationDTO? {
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(name)&page=\(page)") else {
            throw NetworkError.invalidURL
        }
        return try await remoteManager.fetchData(from: url, responseType: PaginationDTO.self)
    }
}
