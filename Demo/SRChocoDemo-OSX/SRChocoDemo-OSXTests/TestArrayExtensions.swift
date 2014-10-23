//
//  TestArrayExtensions.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa
import XCTest

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
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testJoin() {
        let array = [ "This", "is", "test" ]
        let result = array.stringByJoining(" ")
        XCTAssert(result == "This is test")
    }
    
    func testContainString() {
        let array = [ "AAA", "English", "test" ]
        XCTAssert(array.containString("AAA") == true)
        XCTAssert(array.containString("aaa") == false)
        XCTAssert(array.containString("aaa", ignoreCase: true) == true)
        XCTAssert(array.containString("abc", ignoreCase: true) == false)
        XCTAssert(array.containString("english") == false)
        XCTAssert(array.containString("English") == true)
        XCTAssert(array.containString("test") == true)
        XCTAssert(array.containString("What?") == false)
        XCTAssert(array.containString("english", ignoreCase: true) == true)
        XCTAssert(array.containString("TEST", ignoreCase: true) == true)
    }

}
