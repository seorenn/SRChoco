//
//  TestURLExtensions.swift
//  SRChoco
//
//  Created by Heeseung Seo on 2016. 11. 25..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

import XCTest
@testable import SRChoco

class TestURLExtensions: XCTestCase {
  
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
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testFileExistance() {
    XCTAssertFalse(URL(fileURLWithPath: "/very/invalid/url/not/exists/file").isExists)
    XCTAssertTrue(URL(fileURLWithPath: "/Users").isExists)
  }
  
  func testFileType() {
    XCTAssertTrue(URL(fileURLWithPath: "/Users").isDirectory)
    XCTAssertTrue(URL(fileURLWithPath: "/").isRootDirectory)
  }
  
  func testFileInfo() {
    XCTAssertTrue(URL(fileURLWithPath: "/foo/bar/some.txt").lastPathComponentWithoutExtension == "some")
  }
  
  func testConcat() {
    XCTAssertTrue((URL(fileURLWithPath: "/foo/bar") + "something.txt").path == "/foo/bar/something.txt")
  }
}
