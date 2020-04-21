//
//  Decoder.swift
//  
//
//  Created by Pérsio on 20/04/20.
//

import Foundation

/// Decoder protocol
public protocol Decoder {

    /// Decodes the given data to the specified type, since it conforms to Decodable
    /// - Parameters:
    ///   - type: The decoding result type
    ///   - data: The data to be decoded
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}
