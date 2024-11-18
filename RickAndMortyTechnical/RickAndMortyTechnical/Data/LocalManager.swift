//
//  LocalManager.swift
//  RickAndMortyTechnical
//
//  Created by Joan Cremades Meló on 18/11/24.
//

import Foundation

protocol LocalManagerProtocol {
    func set<T: Encodable>(_ value: T?, forKey key: String)
    func get<T: Decodable>(_ type: T.Type, forKey key: String) -> T?
    func removeAll()
}

class LocalManager: LocalManagerProtocol {
    private let userDefaults: UserDefaults
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.jsonEncoder = JSONEncoder()
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func set<T: Encodable>(_ value: T?, forKey key: String) {
        guard let value = value else {
            userDefaults.removeObject(forKey: key)
            return
        }

        do {
            let data = try jsonEncoder.encode(value)
            userDefaults.set(data, forKey: key)
        } catch {
            print("[LocalManager] Error encoding object for key \(key): \(error.localizedDescription)")
        }
    }

    func get<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            print("[LocalManager] No data found for key \(key)")
            return nil
        }

        do {
            let value = try jsonDecoder.decode(type, from: data)
            return value
        } catch {
            print("[LocalManager] Error decoding object for key \(key): \(error.localizedDescription)")
            return nil
        }
    }

    func removeAll() {
        if let appDomain = Bundle.main.bundleIdentifier {
            userDefaults.removePersistentDomain(forName: appDomain)
        }
    }
}
