//
//  StoryboardLoadable.swift
//  Core
//
//  Created by Pérsio on 25/09/20.
//

import UIKit

public protocol StoryboardLoadable {
    static var storyboard: UIStoryboard { get }
}

public extension StoryboardLoadable where Self: Identifiable, Self: UIViewController {
    
    static var fromStoryboard: Self? {
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self
    }
}
