//
//  Filer.swift
//  Core
//
//  Created by Pérsio on 22/04/20.
//

import Foundation

/// A protocol to pattern a filer
public protocol Filer {
    
    /// Creates a file for a given data into a given path
    ///
    /// - Parameters:
    ///   - data: The data to be saved
    ///   - path: The path to save the data
    /// - Returns: The saved data
    /// - Throws: May throw an error if something went wrong while saving the file
    func create(_ data: Data, at path: String) throws -> Data
    
    /// Reads the file of the given path
    ///
    /// - Parameter path: The path of the file you want to read
    /// - Returns: The data of the given path
    /// - Throws: May throw an error if something went wrong while reading the file
    func read(at path: String) throws -> Data
    
    /// Updates the file of the given path
    ///
    /// - Parameters:
    ///   - data: The new data of the file
    ///   - path: The path of the file you want to update
    /// - Returns: The updated data
    /// - Throws: May throw an error if something went wrong while updating the file
    func update(_ data: Data, at path: String) throws -> Data
    
    /// Deletes the file of the given path
    ///
    /// - Parameter path: The path of the file to be deleted
    /// - Throws: Can throw an error if something went wrong while deleting the file
    func delete(at path: String) throws
}
