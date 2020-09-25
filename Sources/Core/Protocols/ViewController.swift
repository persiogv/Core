//
//  ViewController.swift
//  Core
//
//  Created by Pérsio on 25/09/20.
//

import UIKit

public protocol ViewController {
    
    associatedtype T
    
    /// Returns the root view casted to the type you want
    var rootView: T? { get }
}
