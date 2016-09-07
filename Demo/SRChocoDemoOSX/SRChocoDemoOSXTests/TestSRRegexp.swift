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
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
            XCTAssert(regexp.find(fromString: "This is test string")?.count > 0)
            XCTAssert(regexp.find(fromString: "this is TEST STRING")?.count > 0)
            XCTAssertEqual(regexp.find(fromString: "this is test string")?.string(index: 1), "test")
        } else {
            XCTFail()
        }
        
        if let regexp2 = SRRegexp("^[a-zA-Z]+$") {
            XCTAssert(regexp2.find(fromString: "ABCDEFGaaa")?.count > 0)
            XCTAssertNil(regexp2.find(fromString: "1Abccd"))
        } else {
            XCTFail()
        }
    }
    
    func testTest() {
        if let regexp = SRRegexp(".*test.*") {
            XCTAssertTrue(regexp.test(string: "This is test string"))
          XCTAssertTrue(regexp.test(string: "this is TEST STRING"))
        } else {
            XCTFail()
        }
        
        if let regexp2 = SRRegexp("^[a-zA-Z]+$") {
          XCTAssertTrue(regexp2.test(string: "ABCDEFGaaa"))
          XCTAssertFalse(regexp2.test(string: "1Abccd"))
        } else {
            XCTFail()
        }
    }

    func testReplace() {
        if let regexp = SRRegexp(".*(TEST).*") {
            let res = regexp.replace(fromString: "this is TEST string", template: "EXTRACTED: $1")
            XCTAssertEqual(res, "EXTRACTED: TEST")
        } else {
            XCTFail()
        }
    }
}
