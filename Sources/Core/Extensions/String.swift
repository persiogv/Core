//
//  String.swift
//  
//
//  Created by Pérsio on 20/04/20.
//

import Foundation

extension String {
    
    /// Returns the localized value since self is a localizable key
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
