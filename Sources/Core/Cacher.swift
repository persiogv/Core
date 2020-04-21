//
//  Cacher.swift
//  Core
//
//  Created by Pérsio on 31/07/18.
//

import Foundation

/// Class to cache data
public final class Cacher {
    
    // MARK: Enums
    
    /// Expire options enum
    public enum ExpireOptions {
        case never
        case seconds(TimeInterval)
    }
    
    // MARK: Public properties
    
    /// A persistent cacher
    public static var persistent: Cacher { return Cacher(strategy: .persistent) }
    
    /// An ephemeral cacher
    public static let ephemeral = Cacher(strategy: .ephemeral)
    
    // MARK: Private properties
    
    private let strategy: Strategy
    
    private lazy var userDefaults: UserDefaults = {
        return UserDefaults.standard
    }()
    
    private lazy var memory: [String: Any] = {
        return [String: Any]()
    }()
    
    // MARK: Initializers
    
    private init(strategy: Strategy) {
        self.strategy = strategy
    }
    
    // MARK: Public methods
    
    /// Caches the given value with a given key
    ///
    /// - Parameters:
    ///   - value: The value to be cached
    ///   - key: A key to identify the value
    /// - Returns: A copy of the cached value
    public final func cacheValue<T>(_ value: T, toKey key: String, expires: ExpireOptions = .never) -> T? {
        defineExpiration(key: key, expires: expires)
        
        switch strategy {
        case .ephemeral:
            memory[key] = value
        case .persistent:
            userDefaults.set(value, forKey: key)
            userDefaults.synchronize()
        }
        
        return fetchValue(ofType: T.self, fromKey: key)
    }

    /// Gets the value for the given key or nil
    ///
    /// - Parameters:
    ///   - _: The type of the value
    ///   - key: The key of the value
    /// - Returns: The value of the given key or nil
    public final func fetchValue<T>(ofType _: T.Type, fromKey key: String) -> T? {
        let expireKey = expirationKey(from: key)
        
        if case let expireDate as Date = userDefaults.value(forKey: expireKey), expireDate < Date() {
            uncacheValue(ofKey: expireKey)
            uncacheValue(ofKey: key)
            return nil
        }

        var tempValue: Any?
        
        switch strategy {
        case .ephemeral:
            tempValue = memory[key]
        case .persistent:
            tempValue = userDefaults.value(forKey: key)
        }
        
        return tempValue as? T
    }
    
    /// Fetches all values of the given type
    /// - Parameter type: The type of the values
    /// - Returns: The values
    public final func fetchAllValues<T>(ofType type: T.Type) -> [T] {
        var dict = [String: Any]()
        switch strategy {
        case .ephemeral:
            dict = memory
        case .persistent:
            dict = userDefaults.dictionaryRepresentation()
        }
        
        return dict.compactMap { key, _ in fetchValue(ofType: type, fromKey: key) }
    }
    
    /// Removes the value associated with the given key
    ///
    /// - Parameter key: The key of the value
    public final func uncacheValue(ofKey key: String) {
        switch strategy {
        case .ephemeral:
            memory.removeValue(forKey: key)
        case .persistent:
            userDefaults.set(nil, forKey: key)
        }
    }
    
    // MARK: Private methods
    
    private enum Strategy {
        case persistent, ephemeral
    }
    
    private func expirationKey(from key: String) -> String {
        return "\(key)_expire"
    }
    
    private func defineExpiration(key: String, expires: ExpireOptions) {
        let expireKey = expirationKey(from: key)
        
        switch expires {
        case .seconds(let seconds):
            let expireDate = Date().addingTimeInterval(seconds)
            _ = cacheValue(expireDate, toKey: expireKey)
        case .never:
            uncacheValue(ofKey: expireKey)
        }
    }
}
