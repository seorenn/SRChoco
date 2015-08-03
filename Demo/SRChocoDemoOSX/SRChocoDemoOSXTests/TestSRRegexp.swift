//
//  TestSRRegexp.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa
import XCTest
import SRChoco

class TestSRRegexp: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFind() {
        if let regexp = SRRegexp("^.*(test).*$") {
            XCTAssert(regexp.find("This is test string")?.count > 0)
            XCTAssert(regexp.find("this is TEST STRING")?.count > 0)
            XCTAssert(regexp.find("this is test string")?.string(1) == "test")
        } else {
            XCTAssert(false)
        }
        
        if let regexp2 = SRRegexp("^[a-zA-Z]+$") {
            XCTAssert(regexp2.find("ABCDEFGaaa")?.count > 0)
            XCTAssert(regexp2.find("1Abccd") == nil)
        } else {
            XCTAssert(false)
        }
    }
    
    func testTest() {
        if let regexp = SRRegexp(".*test.*") {
            XCTAssert(regexp.test("This is test string"))
            XCTAssert(regexp.test("this is TEST STRING"))
        } else {
            XCTAssert(false)
        }
        
        if let regexp2 = SRRegexp("^[a-zA-Z]+$") {
            XCTAssert(regexp2.test("ABCDEFGaaa"))
            XCTAssert(regexp2.test("1Abccd") == false)
        } else {
            XCTAssert(false)
        }
    }

    func testReplace() {
        if let regexp = SRRegexp(".*(TEST).*") {
            let res = regexp.replace("this is TEST string", template: "EXTRACTED: $1")
            XCTAssert(res == "EXTRACTED: TEST")
        } else {
            XCTAssert(false)
        }
    }
}
