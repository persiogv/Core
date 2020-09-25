//
//  Identifiable.swift
//  Core
//
//  Created by Pérsio on 25/09/20.
//

import UIKit

public protocol Identifiable {}

public extension Identifiable where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}

public extension Identifiable where Self: UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self) + "ReuseIdentifier"
    }
}

public extension Identifiable where Self: UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self) + "ReuseIdentifier"
    }
}

public extension Identifiable where Self: UIViewController {
    static var nibName: String {
        return String(describing: self)
    }

    static var segueIdentifier: String {
        let selfName = String(describing: self)
        let segueIdentifier = selfName.replacingOccurrences(of: "ViewController", with: "SegueIdentifier")
        
        return segueIdentifier
    }
    
    static var storyboardIdentifier: String {
        let selfName = String(describing: self)
        let storyboardIdentifier = selfName.replacingOccurrences(of: "ViewController", with: "StoryboardIdentifier")

        return storyboardIdentifier
    }
}
