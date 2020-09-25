//
//  Loadable.swift
//  Core
//
//  Created by Pérsio on 25/09/20.
//

import UIKit

public protocol Loadable {
    
    func beforeLoading()
    
    func afterLoading()
}

extension Loadable where Self: UIView {
    
    public func beforeLoading() {}
    
    public func afterLoading() {}
    
    public func startLoading() {
        beforeLoading()
    }
    
    public func stopLoading() {
        afterLoading()
    }
}
