//
//  TestStringExtensions.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
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
    
    func testSubscript() {
        let str = "123 ABC abc-"
        XCTAssert(str[0] == Character("1"))
        XCTAssert(str[4] == Character("A"))
        XCTAssert(str[-1] == Character("-"))
        XCTAssert(str[-2] == Character("c"))
    }
    func testSubstring() {
        let strA = "This is test string..."
        let strB = strA[1...3]
        XCTAssert(strB == "his")
        XCTAssert(strA[2...5] == "is i")
        let strC = strA[1..<3]
        XCTAssert(strC == "hi")
        let strD = strA[NSMakeRange(0, 3)]
        XCTAssert(strD == "Thi")
        let strE = strA[NSMakeRange(5, 4)]
        XCTAssert(strE == "is t")
    }

    func testTrim() {
        let strA = "   A string   "
        XCTAssertEqual(strA.trimmedString(), "A string")
    }
    
    func testContain() {
        let str = "This is test string by test contain"
        XCTAssertTrue(str.containString("test"))
        XCTAssertFalse(str.containString("TEST"))
        XCTAssertTrue(str.containString("TEST", ignoreCase: true))
        
        XCTAssertTrue(str.containStrings(["is", "test", "string"]))
        XCTAssertTrue(str.containStrings(["is", "test", "string"], ORMode: false, ignoreCase: false))
        XCTAssertTrue(str.containStrings(["IS", "TEST", "String"], ORMode: false, ignoreCase: true))
        
        XCTAssertTrue(str.containStrings(["is", "testxx", "nonstring", "aaa"], ORMode: true))
        XCTAssertTrue(str.containStrings(["IS", "XX", "non", "aaa"], ORMode: true, ignoreCase: true))
        
        XCTAssertFalse(str.containStrings(["aaa", "bbb"]))
    }
    
    func testSplit() {
        let str = "This is test"
        let array = str.arrayBySpliting()
        XCTAssertTrue(array.count == 3)
        XCTAssertTrue(array[0] == "This")
        XCTAssertTrue(array[1] == "is")
        XCTAssertTrue(array[2] == "test")
    }
}





