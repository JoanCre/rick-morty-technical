//
//  RemoteManager.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case invalidData
    case decodingFailed

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid. Please make sure it is correct."
        case .requestFailed(let statusCode):
            return "The request failed with status code \(statusCode)."
        case .invalidData:
            return "The data received from the server is invalid."
        case .decodingFailed:
            return "Failed to decode the response from the server."
        }
    }
}

protocol RemoteManagerProtocol {
    func fetchData<T: Decodable>(from url: URL, responseType: T.Type) async throws -> T
}

final class RemoteManager: RemoteManagerProtocol {
    private let jsonDecoder: JSONDecoder
    private let validStatusCodes = 200..<300

    init() {
        jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func fetchData<T: Decodable>(from url: URL, responseType: T.Type) async throws -> T {
        guard isValidURL(url) else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            try validateResponse(response)
            return try jsonDecoder.decode(T.self, from: data)
        } catch let urlError as URLError {
            throw NetworkError.requestFailed(statusCode: urlError.errorCode)
        } catch is DecodingError {
            throw NetworkError.decodingFailed
        } catch {
            throw error
        }
    }

    private func isValidURL(_ url: URL) -> Bool {
        return url.scheme == "https"
    }

    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, validStatusCodes.contains(httpResponse.statusCode) else {
            throw NetworkError.requestFailed(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }
    }
}
