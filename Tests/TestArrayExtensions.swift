//
//  TestArrayExtensions.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation
import XCTest
import SRChoco

class TestArrayExtensions: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testJoin() {
        let array = [ "This", "is", "test" ]
        let result = array.stringByJoining(separator: " ")
        XCTAssertEqual(result, "This is test")
    }
    
    func testSafeArray() {
        let array = [ 1, 2, 3, 4, 5 ]
        
        XCTAssertEqual(array[0], 1)
        XCTAssertEqual(array[4], 5)
        XCTAssertEqual(array[5, default: 0], 0)
        XCTAssertNil(array[safeIndex: 5])
        XCTAssertNotNil(array[safeIndex: 0])
        XCTAssertNotNil(array[safeIndex: 4])
    }
}
