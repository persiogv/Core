//
//  NibLoadable.swift
//  Core
//
//  Created by Pérsio on 25/09/20.
//

import UIKit

public protocol NibLoadable {}

public extension NibLoadable where Self: UIView {
    
    static var fromNib: Self {
        let nibName = "\(self)".split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}

public extension NibLoadable where Self: UIViewController {
    
    static var fromNib: Self {
        let nibName = "\(self)".split{$0 == "."}.map(String.init).last!
        return Self(nibName: nibName, bundle: nil)
    }
}
