//
//  TestStringExtensions.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 8. 10..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

import Cocoa
import XCTest
import SRChocoDemo_OSX

class TestStringExtensions: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSubstring() {
        let strA = "This is test string..."
        let strB = strA[1...3]
        XCTAssert(strB == "his")
        let strC = strA[1..<3]
        XCTAssert(strC == "hi")
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

}
