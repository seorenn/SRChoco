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

    func testTrim() {
        let strA = "   A string   "
        XCTAssertEqual(strA.trimmedString(), "A string")
    }
    
    func testContain() {
        let str = "This is test string by test contain"
        XCTAssertTrue(str.containString("test"))
        XCTAssertFalse(str.containString("TEST"))
        
        XCTAssertTrue(str.containStrings(["is", "test", "string", "aaa"]))
        XCTAssertFalse(str.containStrings(["aaa", "bbb"]))
    }
}
