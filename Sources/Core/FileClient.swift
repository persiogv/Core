//
//  FileClient.swift
//  Core
//
//  Created by Pérsio on 17/03/19.
//

import Foundation

/// A client to handle files
public struct FileClient {
    
    // MARK: Enums
    
    /// Errors enum
    public enum FileClient: Error {
        case notFound(_ path: String)
        case unauthorized(_ message: String)
    }
    
    // MARK: Properties
    
    private let fileManager: FileManager
    
    // MARK: Initializer
    
    /// Initializer
    /// - Parameter fileManager: A FileManager instance. Defaults to .default
    public init(with fileManager: FileManager = .default) {
        self.fileManager = fileManager
    }
}

// MARK: - Filer
extension FileClient: Filer {
    
    public func create(_ data: Data, at path: String) throws -> Data {
        if fileManager.createFile(atPath: path, contents: data, attributes: nil) {
            return try read(at: path)
        }
        
        throw FileClient.unauthorized("Unable do save file at: \(path)")
    }
    
    public func read(at path: String) throws -> Data {
        if fileManager.fileExists(atPath: path) {
            guard let data = fileManager.contents(atPath: path) else {
                throw FileClient.notFound(path)
            }
            
            return data
        }
        
        throw FileClient.notFound("Could not found file at: \(path)")
    }
    
    public func update(_ data: Data, at path: String) throws -> Data {
        if fileManager.fileExists(atPath: path) {
            try delete(at: path)
        }
        
        return try create(data, at: path)
    }
    
    public func delete(at path: String) throws {
        if fileManager.fileExists(atPath: path) {
            return try fileManager.removeItem(atPath: path)
        }
        
        throw FileClient.notFound("Could not found file at: \(path)")
    }
}
