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
    
    func testSRDirectoryCreateAndRemove() {
        let path = SRDirectory.pathForDocuments!.stringByAppendingPathComponent("SRDirectoryTest")
        let dir = SRDirectory(creatingPath: path, withIntermediateDirectories: false)
        XCTAssert(dir != nil)
        XCTAssert(dir!.exists == true)
        
        XCTAssert(dir!.trash(removingAllSubContents: false) == true)
        XCTAssert(dir!.exists == false)
    }
    
    func testSRDirectoryCreateAndRemoveWithIntermediation() {
        let path = SRDirectory.pathForDocuments!.stringByAppendingPathComponent("SRDirectoryTest/Another/Deep/Directory")
        let dir = SRDirectory(creatingPath: path, withIntermediateDirectories: true)
        XCTAssert(dir != nil)
        XCTAssert(dir!.exists == true)

        let removingPath = SRDirectory.pathForDocuments!.stringByAppendingPathComponent("SRDirectoryTest")
        let remDir = SRDirectory(removingPath)
        XCTAssert(remDir.trash(removingAllSubContents: true) == true)
        XCTAssert(remDir.exists == false)
    }

    func testSRFileMisc() {
        XCTAssert(SRFile("/invalid/file/path/") == nil)
        let f = SRFile("/not/exists/path/file")!
        XCTAssert(f.path == "/not/exists/path/file")
        XCTAssert(f.name == "file")
        XCTAssert(f.parentDirectory != nil)
        XCTAssert(f.parentDirectory!.path == "/not/exists/path")
    }
    
    func testSRFileOperations() {
        let d = NSDate()
        let dateString = NSString(format: "%02d%02d%02dT%02d%02d%02d", d.year, d.month, d.day, d.hour, d.minute, d.second)
        let filename = "SRFileTest-\(dateString).txt"
        let path = SRDirectory.pathForDocuments?.stringByAppendingPathComponent(filename)
        println("Test uses this file path: \(path)")
        if let f = SRFile(path!) {
            XCTAssert(f.exists == false)
            XCTAssert(f.data == nil)

            let content = "Hello World!\n(This is test text document wrote by SRFile)\n"
            let data = content.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            f.data = data
            XCTAssert(f.exists == true)
        
            let readedData = f.data
            XCTAssert(readedData != nil)
            let readedContent = NSString(data: readedData!, encoding: NSUTF8StringEncoding)
        
            XCTAssert(readedContent == content)
            
            XCTAssert(f.trash() == true)
            XCTAssert(f.exists == false)
        } else {
            XCTAssert(false)
        }
    }
    
    func testSRFileLazyOperations() {
        let d = NSDate()
        let dateString = NSString(format: "%02d%02d%02dT%02d%02d%02d", d.year, d.month, d.day, d.hour, d.minute, d.second)
        let filename = "SRFileTest-Lazy-\(dateString).txt"
        let path = SRDirectory.pathForDocuments?.stringByAppendingPathComponent(filename)
        println("Test uses this file path: \(path)")
        if let f = SRFile(path!) {
            XCTAssert(f.exists == false)
            XCTAssert(f.data == nil)
            
            let content = "Hello Lazy World!\n(This is test text document wrote by SRFile)\n"
            let wdata = content.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
            f.write(wdata, completion: { (succeed) -> Void in
                XCTAssert(succeed == true)
                XCTAssert(f.exists == true)
                
                f.read({ (data) -> Void in
                    XCTAssert(data != nil)
                    let readedContent = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    XCTAssert(readedContent == content)
                    
                    XCTAssert(f.trash() == true)
                    XCTAssert(f.exists == false)
                })
            })
        } else {
            XCTAssert(false)
        }
    }
}
