//
//  TestSRJSON.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 2. 26..
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

import Cocoa
import XCTest
import SRChoco

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
        XCTAssertNil(SRJSON.jsonWithString(""))
        XCTAssertNotNil(SRJSON.jsonWithString("{ }"))
    }
    
    func testJSON1() {
        let json = SRJSON.jsonWithString("{ \"name\": \"value\" }")
        XCTAssertNotNil(json)
        XCTAssertNotNil(json!["name"])
        XCTAssertEqual(json!["name"]?.stringValue!, "value")
    }
    
    func testJSON2() {
        let json = SRJSON.jsonWithString("{ \"int\": 100, \"float\": 10.5, \"null\": null }")
        XCTAssertNotNil(json)
        XCTAssertEqual(json!["int"]?.intValue, 100)
        XCTAssertEqual(json!["float"]?.floatValue, 10.5)
        XCTAssertTrue(json!["null"]!.isNull)
        XCTAssertNil(json!["notFound"])
    }
    
    func testJSON3() {
        let json = SRJSON.jsonWithString("{ \"results\": [ { \"name\": \"first\", \"value\": 0 }, { \"name\": \"second\", \"value\": 1 } ] }")
        XCTAssertNotNil(json)
        XCTAssertEqual(json!["results"]?[0]?["name"]?.stringValue, "first")
        XCTAssertEqual(json!["results"]?[1]?["value"]?.intValue, 1)
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
