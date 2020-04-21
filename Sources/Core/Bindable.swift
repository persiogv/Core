//
//  Bindable.swift
//  Core
//
//  Created by Pérsio on 18/04/20.
//

import Foundation

/// Class to bind/wrap values
public final class Bindable<T> {
    
    // MARK: Typealiases
    
    /// Bind closure typealias
    public typealias BindType = ((T) -> Void)
    
    // MARK: Properties
    
    private var binds: [BindType] = []
    
    public var value: T {
        didSet {
            execBinds()
        }
    }
    
    // MARK: Initializers
    
    /// Initializer
    /// - Parameter val: The value to be stored
    public init(_ val: T) {
        value = val
    }
    
    // MARK: Public methods
    
    /// Binds
    /// - Parameter bind: The binding closure
    public func bind(_ bind: @escaping BindType) {
        binds.append(bind)
        bind(value)
    }
    
    // MARK: Private methods
    
    private func execBinds() {
        binds.forEach { [weak self] bind in
            guard let value = self?.value else { return }
            
            bind(value)
        }
    }
}
