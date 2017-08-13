//
//  Worker.swift
//  ThreadSafe
//
//  Created by Stehling, Brennan on 8/13/17.
//  Copyright © 2017 Amazon. All rights reserved.
//

import Foundation

public class Worker: ThreadSafe {
    
    private var _identifier: String!
    private var identifier: String {
        synchronized {
            if _identifier == nil {
                _identifier = UUID().uuidString
            }
        }
        return _identifier
    }
    
    public func work() {
        synchronized {
            debugPrint("Identifier: \(identifier)")
        }
    }
    
    private func workJobOne() {
        synchronized {
            debugPrint("Job 1")
        }
    }
    
    private func workJobTwo() {
        synchronized { () -> String in
            debugPrint("Job 2")
            return "two"
        }
    }
    
    public func workTwoJobs() {
        workJobOne()
        workJobTwo()
    }
    
    public func workSameJobTwice() {
        workJobOne()
        workJobOne()
    }
    
    public func workNestedJob() {
        synchronized {
            debugPrint("Job 1")
            synchronized {
                debugPrint("Job 2")
            }
        }
    }

}
