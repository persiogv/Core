//
//  Logger.swift
//  Core
//
//  Created by Pérsio on 31/07/18.
//

import Foundation
import os

/// Class to log infos to the unified logging system
public struct Logger {

    // MARK: Enums

    /// Log categories enum (fell free to increment it)
    public enum Category: String {
        /// Analytics log category
        case analytics
        /// Crashlytics log category
        case crashlytics
        /// Networking log category
        case networking
    }

    /// Log levels enum (no increments are needed)
    public enum Level {
        /// Info log level
        case info
        /// Degub log level
        case debug
        /// Error log level
        case error

        /// Casts to OSLogType
        var logType: OSLogType {
            switch self {
            case .info:
                return .info
            case .debug:
                return .debug
            case .error:
                return .error
            }
        }
    }
    
    // MARK: Private enums

    private enum Constants {
        static let fileName = "Info"
    }
    
    // MARK: Private values
    
    private struct InfoPList: Codable {

        enum CodingKeys: String, CodingKey {
            case developmentLanguage = "CFBundleDevelopmentRegion"
            case bundleIdentifier = "CFBundleIdentifier"
        }
        
        var developmentLanguage: String?
        var bundleIdentifier: String?
    }

    // MARK: - Private properties

    private let subsystem: String
    private let level: Level
    private let category: Category

    // MARK: Initializers

    /// Initializer
    /// - Parameters:
    ///   - bundle: The caller's current bundle
    ///   - level: The log level
    ///   - category: The log category
    public init(bundle: Bundle, level: Level, category: Category) {
        let file = FileRepresentation(withFileName: Constants.fileName, fileExtension: .plist, fileBundle: bundle)
        let info = try? file.decoded(to: InfoPList.self, using: PropertyListDecoder())
        subsystem = info?.bundleIdentifier ?? ""

        self.level = level
        self.category = category
    }

    // MARK: Public methods

    /// Logs
    /// - Parameter message: The message to be logged
    public func log(message: String) {
        let log = OSLog(subsystem: subsystem, category: category.rawValue)
        os_log("%s", log: log, type: level.logType, message)
    }
}
