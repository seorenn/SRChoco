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
            XCTAssertEqual(regexp.find("this is test string")?.string(1), "test")
        } else {
            XCTFail()
        }
        
        if let regexp2 = SRRegexp("^[a-zA-Z]+$") {
            XCTAssert(regexp2.find("ABCDEFGaaa")?.count > 0)
            XCTAssertNil(regexp2.find("1Abccd"))
        } else {
            XCTFail()
        }
    }
    
    func testTest() {
        if let regexp = SRRegexp(".*test.*") {
            XCTAssertTrue(regexp.test("This is test string"))
            XCTAssertTrue(regexp.test("this is TEST STRING"))
        } else {
            XCTFail()
        }
        
        if let regexp2 = SRRegexp("^[a-zA-Z]+$") {
            XCTAssertTrue(regexp2.test("ABCDEFGaaa"))
            XCTAssertFalse(regexp2.test("1Abccd"))
        } else {
            XCTFail()
        }
    }

    func testReplace() {
        if let regexp = SRRegexp(".*(TEST).*") {
            let res = regexp.replace("this is TEST string", template: "EXTRACTED: $1")
            XCTAssertEqual(res, "EXTRACTED: TEST")
        } else {
            XCTFail()
        }
    }
}
