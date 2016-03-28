//
//  TestUUID.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 10. 8..
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa
import XCTest
import SRChoco

class TestUUID: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

    func testDefaultUUID() {
        var uuids = [String]()
        let testCount = 50
        
        for _ in 0..<testCount {
            let uuid = SRUUID()
            uuids.append(uuid.normalizedString)
        }
        
        for currentUUID in uuids {
            var matchCount = 0
            for occurUUID in uuids {
                if occurUUID == currentUUID {
                    matchCount += 1
                }
            }
            XCTAssertEqual(matchCount, 1)
        }
    }
}
