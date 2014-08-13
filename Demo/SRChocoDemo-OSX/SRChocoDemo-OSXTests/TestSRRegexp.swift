//
//  TestSRRegexp.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 8. 7..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

import Cocoa
import XCTest
import SRChocoDemo_OSX

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
        let regexp = SRRegexp(".*test.*")
        XCTAssert(regexp.find("This is test string")?.count > 0)
        XCTAssert(regexp.find("this is TEST STRING")?.count > 0)
        
        let regexp2 = SRRegexp("^[a-zA-Z]+$")
        XCTAssert(regexp2.find("ABCDEFGaaa")?.count > 0)
        XCTAssert(regexp2.find("1Abccd")?.count == 0)
    }
    
    func testTest() {
        let regexp = SRRegexp(".*test.*")
        XCTAssert(regexp.test("This is test string"))
        XCTAssert(regexp.test("this is TEST STRING"))
        
        let regexp2 = SRRegexp("^[a-zA-Z]+$")
        XCTAssert(regexp2.test("ABCDEFGaaa"))
        XCTAssert(regexp2.test("1Abccd") == false)
    }

    func testReplace() {
        let regexp = SRRegexp(".*(TEST).*")
        let res = regexp.replace("this is TEST string", template: "EXTRACTED: $1")
        XCTAssert(res == "EXTRACTED: TEST")
    }
}
