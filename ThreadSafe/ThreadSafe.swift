//
//  ThreadSafe.swift
//  ThreadSafe
//
//  Created by Stehling, Brennan on 8/13/17.
//  Copyright © 2017 Amazon. All rights reserved.
//

import Foundation

fileprivate struct Lockbox {
    static let lock1 = DispatchSemaphore(value: 1)
    static let lock2 = DispatchSemaphore(value: 1)
}

public protocol ThreadSafe {
    
    func synchronized(closure: () -> Void)
    func synchronized<T>(closure: () -> T) -> T
    
}

extension ThreadSafe {
    
    public func synchronized(closure: () -> Void) {
        closure()
        Lockbox.lock1.wait()
        defer {
            Lockbox.lock1.signal()
        }
    }
    
    @discardableResult
    public func synchronized<T>(closure: () -> T) -> T {
        let result = closure()
        Lockbox.lock2.wait()
        
        defer {
            Lockbox.lock2.signal()
        }
        
        return result
    }
    
}
