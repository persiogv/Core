//
//  Manager.swift
//  Core
//
//  Created by Pérsio on 18/04/20.
//

import Foundation

/// Base class for managers
open class Manager: OperationQueue {
    
    // MARK: Initializers
    
    public override init() {
        super.init()
        name = String(describing: self)
    }
    
    // MARK: Public methods
    
    /// Executes the given operation in main queue
    /// - Parameter operation: The operation to be executed in main queue
    public final func executeInMainQueue(operation: Operation) {
        OperationQueue.main.addOperation(operation)
    }
    
    // MARK: Deinitializer
    
    deinit {
        cancelAllOperations()
    }
}
