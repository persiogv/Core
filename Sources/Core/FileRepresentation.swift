//
//  FileRepresentation.swift
//  Core
//
//  Created by Pérsio on 18/04/20.
//

import Foundation

/// Decoder protocol adoptance
extension PropertyListDecoder: Decoder {
    /* Intentionally unimplemented */
}

/// Decoder protocol adoptance
extension JSONDecoder: Decoder {
    /* Intentionally unimplemented */
}

/// File representation
public struct FileRepresentation {
    
    // MARK: Enums
    
    /// Handled errors enum
    public enum FileRepresentationError: Error {
        case invalidData
    }
    
    /// Supported extensions enum
    public enum Extension: String {
        case json
        case html
        case pdf
        case plist
    }
    
    // MARK: Private properties
    
    private var fileName: String?
    private var fileExtension: Extension?
    private var fileBundle: Bundle?
    private var fileData: Data?
    
    // MARK: Public properties
    
    /// Path string
    public var path: String? {
        guard let url = fileBundle?.url(forResource: fileName ?? String(), withExtension: fileExtension?.rawValue ?? String()) else { return String() }
        return url.absoluteString
    }
    
    /// Data representation
    public var data: Data? {
        if let data = fileData {
            return data
        }
        
        guard let url = fileBundle?.url(forResource: fileName ?? String(), withExtension: fileExtension?.rawValue ?? String()) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        return data
    }
    
    // MARK: Initializers
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - fileName: File name
    ///   - fileExtension: File extension
    ///   - fileBundle: File bundle
    public init(withFileName fileName: String, fileExtension: Extension, fileBundle: Bundle) {
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.fileBundle = fileBundle
    }
    
    /// Initializer
    ///
    /// - Parameter fileData: file data
    public init(withFileData fileData: Data) {
        self.fileData = fileData
    }
    
    // MARK: Public methods
    
    /// Return file model
    ///
    /// - Parameters:
    ///   - type: O tipo do model requeride Decodable)
    ///   - decoder: Custom JSONDecoder, if necessary
    /// - Returns: File model
    /// - Throws: Throw exceptions in case of an error in obtaining the binary or decoding
    public func decoded<T: Decodable>(to type: T.Type, using decoder: Decoder) throws -> T {
        guard let data = data else { throw FileRepresentationError.invalidData }
        
        return try decoder.decode(type, from: data)
    }
}
