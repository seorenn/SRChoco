//
//  TestSRJSON.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 2. 26..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

import Cocoa
import XCTest
import SRChocoDemo_OSX

class TestSRJSON: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFailable() {
        XCTAssert(SRJSON.jsonWithString("") == nil)
        XCTAssert(SRJSON.jsonWithString("{ }") != nil)
    }
    
    func testJSON1() {
        let json = SRJSON.jsonWithString("{ \"name\": \"value\" }")
        XCTAssert(json != nil)
        XCTAssert(json!["name"] != nil)
        XCTAssert(json!["name"]?.stringValue! == "value")
    }
    
    func testJSON2() {
        let json = SRJSON.jsonWithString("{ \"int\": 100, \"float\": 10.5, \"null\": null }")
        XCTAssert(json != nil)
        XCTAssert(json!["int"]?.intValue == 100)
        XCTAssert(json!["float"]?.floatValue == 10.5)
        XCTAssert(json!["null"]?.isNull == true)
        XCTAssert(json!["notFound"] == nil)
    }
    
    func testJSON3() {
        let json = SRJSON.jsonWithString("{ \"results\": [ { \"name\": \"first\", \"value\": 0 }, { \"name\": \"second\", \"value\": 1 } ] }")
        XCTAssert(json != nil)
        XCTAssert(json!["results"]?[0]?["name"]?.stringValue == "first")
        XCTAssert(json!["results"]?[1]?["value"]?.intValue == 1)
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
