//
//  TestSRFileManager.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 10. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

import Cocoa
import XCTest

class TestSRFileManager: XCTestCase {

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
    
    func testSRDirectoryBasics() {
        XCTAssert(SRDirectory.pathForDownloads != nil)
        XCTAssert(SRDirectory.pathForDocuments != nil)
        
        if let home = SRDirectory.pathForHome {
            XCTAssert(home.containString("/Users/"))
        } else {
            XCTAssert(false)
        }
    }
    
    func testSRDirectoryMisc() {
        let dir = SRDirectory("/not/exists/path")
        XCTAssert(dir.exists == false)
        
        let downloadsDir = SRDirectory(SRDirectory.pathForDownloads!)
        XCTAssert(downloadsDir.exists == true)
        
        XCTAssert(downloadsDir.name == "Downloads")
        
        XCTAssert(SRDirectory("/test/directory/").name == "directory")
        XCTAssert(SRDirectory("/test/directory/").path == "/test/directory")
        XCTAssert(SRDirectory("/test/directory").name == "directory")
        XCTAssert(SRDirectory("/test/directory").path == "/test/directory")
    }

    func testSRFileMisc() {
        XCTAssert(SRFile("/invalid/file/path/") == nil)
        let f = SRFile("/not/exists/path/file")!
        XCTAssert(f.path == "/not/exists/path/file")
        XCTAssert(f.name == "file")
        XCTAssert(f.parentDirectory != nil)
        XCTAssert(f.parentDirectory!.path == "/not/exists/path")
    }
}
