//
//  NSDateExtensionsTest.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation
import XCTest
import SRChoco

class TestNSDateExtensions: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testDateComponents() {
    let now = Date()
    let dc = now.dateComponents
    XCTAssertNotNil(dc)
    
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    let components = calendar.dateComponents([ .year, .month, .day, . hour, .minute, .second ], from: now)
    
    XCTAssertEqual(dc!.year, components.year!)
    XCTAssertEqual(dc!.month, components.month!)
    XCTAssertEqual(dc!.day, components.day!)
    XCTAssertEqual(dc!.hour, components.hour!)
    XCTAssertEqual(dc!.minute, components.minute!)
    XCTAssertEqual(dc!.second, components.second!)
    
    XCTAssertEqual(dc!.year, now.year)
    XCTAssertEqual(dc!.month, now.month)
    XCTAssertEqual(dc!.day, now.day)
    XCTAssertEqual(dc!.hour, now.hour)
    XCTAssertEqual(dc!.minute, now.minute)
    XCTAssertEqual(dc!.second, now.second)
  }
  
  /*
   TODO: cannot build this in currently
   func testDateComparison() {
   let now = Date()
   let dc = now.dateComponents!
   
   let nextYearDate = Date.generate(year: dc.year+1, month: dc.month, day: dc.day, hour: dc.hour, minute: dc.minute, second: dc.second)!
   let prevYearDate = Date.generate(year: dc.year-1, month: dc.month, day: dc.day, hour: dc.hour, minute: dc.minute, second: dc.second)!
   
   XCTAssert(now < nextYearDate)
   XCTAssert(nextYearDate > now)
   XCTAssertEqual(now, now)
   XCTAssert(now > prevYearDate)
   XCTAssert(prevYearDate < now)
   }
   */
  
  func testDateCreation() {
    let dt = Date.generate(year: 1949, month: 7, day: 21, hour: 12, minute: 25, second: 59)!
    let dc = dt.dateComponents
    XCTAssertEqual(dc!.year, 1949)
    XCTAssertEqual(dc!.month, 7)
    XCTAssertEqual(dc!.day, 21)
    XCTAssertEqual(dc!.hour, 12)
    XCTAssertEqual(dc!.minute, 25)
    XCTAssertEqual(dc!.second, 59)
  }
  
  func testDateDelta() {
    let dt = Date.generate(year: 1979, month: 4, day: 20, hour: 12, minute: 22, second: 55)
    let delta = SRTimeDelta(second: 5)
    let res = dt! + delta
    XCTAssertEqual(dt!.year, res.year)
    XCTAssertEqual(dt!.month, res.month)
    XCTAssertEqual(dt!.day, res.day)
    XCTAssertEqual(dt!.hour, res.hour)
    XCTAssertEqual(res.minute, dt!.minute + 1)
    XCTAssertEqual(res.second, 0)
    
    let delta2 = SRTimeDelta(minute: 50)
    let res2 = dt! + delta2
    XCTAssertEqual(dt!.year, res2.year)
    XCTAssertEqual(dt!.month, res2.month)
    XCTAssertEqual(dt!.day, res2.day)
    XCTAssertEqual(res2.hour, dt!.hour + 1)
    XCTAssertEqual(res2.minute, 12)
    XCTAssertEqual(res2.second, 55)
  }
  
  func testDiffBetweenDates() {
    let now = Date()
    let fut = Date.generate(year: now.year, month: now.month, day: now.day, hour: now.hour+1, minute: now.minute, second: now.second, nanosecond: now.nanosecond)
    // TODO: Test Code cannot recognize my '-' operator overloads from NSDate Extension.
    // Test with next Xcode and change testing method using overloads
    // let dif = fut! - now
    let secs = fut!.timeIntervalSince(now)
    let dif = SRTimeDelta(interval: secs)
    
    XCTAssertEqual(Int(dif.interval), 60*60)
    XCTAssertEqual(dif.second, 60*60)
    XCTAssertEqual(dif.hour, 1)
  }
}
