//
//  InfoPlist.swift
//  Core
//
//  Created by Pérsio on 18/04/20.
//

import Foundation

public struct InfoPList: Codable {

    // MARK: Coding Keys

    enum CodingKeys: String, CodingKey {
        case serverUrl = "Server URL"
        case developmentLanguage = "CFBundleDevelopmentRegion"
        case bundleIdentifier = "CFBundleIdentifier"
    }

    // MARK: Properties

    /// serverURL
    public var serverUrl: String?

    /// developmentLanguage
    public var developmentLanguage: String?

    /// bundleIdentifier
    public var bundleIdentifier: String?
}