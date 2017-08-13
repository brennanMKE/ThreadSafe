//
//  ThreadSafeTests.swift
//  ThreadSafeTests
//
//  Created by Stehling, Brennan on 8/13/17.
//  Copyright © 2017 Amazon. All rights reserved.
//

import XCTest
@testable import ThreadSafe

class ThreadSafeTests: XCTestCase {
    
    func testWorkOnce() {
        let expectation = self.expectation(description: "Worker")
        let worker = Worker()
        worker.work()
        expectation.fulfill()
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testWorkManyTimes() {
        let expectation = self.expectation(description: "Worker")
        
        var count = 0
        let max = 10
        let worker = Worker()
        debugPrint("before")
        for i in 0..<max {
            debugPrint("\(i):")
            worker.work()
            count += 1
            debugPrint("count is \(count)")
            if count == max {
                expectation.fulfill()
            }
        }
        debugPrint("after")
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testNoDeadlock1() {
        let expectation = self.expectation(description: "Worker")
        
        var count = 0
        let max = 10
        let worker = Worker()
        debugPrint("before")
        for _ in 0..<max {
            worker.workTwoJobs()
            count += 1
            if count == max {
                debugPrint("count is \(count)")
                expectation.fulfill()
            }
        }
        debugPrint("after")
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testNoDeadlock2() {
        let expectation = self.expectation(description: "Worker")
        
        var count = 0
        let max = 10
        let worker = Worker()
        debugPrint("before")
        for _ in 0..<max {
            worker.workSameJobTwice()
            count += 1
            if count == max {
                debugPrint("count is \(count)")
                expectation.fulfill()
            }
        }
        debugPrint("after")
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testNoDeadlock3() {
        let expectation = self.expectation(description: "Worker")
        
        var count = 0
        let max = 10
        let worker = Worker()
        debugPrint("before")
        for _ in 0..<max {
            worker.workNestedJob()
            count += 1
            if count == max {
                debugPrint("count is \(count)")
                expectation.fulfill()
            }
        }
        debugPrint("after")
        
        waitForExpectations(timeout: 1.0) { (error) in
            XCTAssertNil(error)
        }
    }
    
}
