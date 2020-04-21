//
//  AsyncOperation.swift
//  Core
//
//  Created by Pérsio on 18/04/20.
//

import Foundation

/// Add async capability to Operation
open class AsyncOperation: Operation {
    
    // MARK: Enums
    
    /// States enum
    public enum State: String {
        case ready = "isReady"
        case executing = "isExecuting"
        case finished = "isFinished"
        case cancelled = "isCancelled"
    }
    
    // MARK: Private properties
    
    private var state: State = .ready {
        willSet {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        didSet {
            didChangeValue(forKey: state.rawValue)
            didChangeValue(forKey: oldValue.rawValue)
        }
    }
    
    // MARK: Properties overrides
    
    public final override var isReady: Bool {
        if state == .ready {
            return super.isReady
        }
        
        return state == .ready
    }
    
    public final override var isExecuting: Bool {
        if state == .executing {
            return super.isExecuting
        }
        
        return state == .executing
    }
    
    public final override var isFinished: Bool {
        if state == .finished {
            return super.isFinished
        }
        
        return state == .finished
    }
    
    public final override var isCancelled: Bool {
        if state == .cancelled {
            return super.isCancelled
        }
        
        return state == .cancelled
    }
    
    public final override var isAsynchronous: Bool {
        return true
    }
    
    // MARK: Method overrides
    
    open override func main() {
        state = isCancelled
            ? .finished
            : .executing
    }
    
    // MARK: Public methods
    
    /// Finishes the operarion
    public final func finish() {
        state = .finished
    }
}
