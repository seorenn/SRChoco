//
//  TestSRHTTP.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 12. 3..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

import Cocoa
import XCTest

class TestSRHTTP: XCTestCase {

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
    
    func testHeaderMakingUp() {
        // make request instance, setup header, setup srhttp common header, merge.
        // is that ok?
    }

}