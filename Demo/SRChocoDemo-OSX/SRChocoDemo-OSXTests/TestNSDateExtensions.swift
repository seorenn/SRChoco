//
//  NSDateExtensionsTest.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa
import XCTest
import SRChocoDemo_OSX

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
        let now = NSDate()
        let dc = now.dateComponents
        XCTAssert(dc != nil)
        
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: now)
            
            XCTAssert(dc!.year == components.year)
            XCTAssert(dc!.month == components.month)
            XCTAssert(dc!.day == components.day)
            XCTAssert(dc!.hour == components.hour)
            XCTAssert(dc!.minute == components.minute)
            XCTAssert(dc!.second == components.second)
            
            XCTAssert(dc!.year == now.year)
            XCTAssert(dc!.month == now.month)
            XCTAssert(dc!.day == now.day)
            XCTAssert(dc!.hour == now.hour)
            XCTAssert(dc!.minute == now.minute)
            XCTAssert(dc!.second == now.second)
        }
    }
    
    func testDateComparison() {
        let now = NSDate()
        let dc = now.dateComponents!
        
        let nextYearDate = NSDate.generate(year: dc.year+1, month: dc.month, day: dc.day, hour: dc.hour, minute: dc.minute, second: dc.second)!
        let prevYearDate = NSDate.generate(year: dc.year-1, month: dc.month, day: dc.day, hour: dc.hour, minute: dc.minute, second: dc.second)!
        
        XCTAssert(now < nextYearDate)
        XCTAssert(nextYearDate > now)
        XCTAssert(now == now)
        XCTAssert(now > prevYearDate)
        XCTAssert(prevYearDate < now)
    }

    func testDateCreation() {
        let dt = NSDate.generate(year: 1949, month: 7, day: 21, hour: 12, minute: 25, second: 59)!
        let dc = dt.dateComponents
        XCTAssertEqual(dc!.year, 1949)
        XCTAssertEqual(dc!.month, 7)
        XCTAssertEqual(dc!.day, 21)
        XCTAssertEqual(dc!.hour, 12)
        XCTAssertEqual(dc!.minute, 25)
        XCTAssertEqual(dc!.second, 59)
    }
    
    func testDateDelta() {
        let dt = NSDate.generate(year: 1979, month: 4, day: 20, hour: 12, minute: 22, second: 55)
        let delta = SRTimeDelta(second: 5)
        let res = dt! + delta
        XCTAssert(dt!.year == res.year)
        XCTAssert(dt!.month == res.month)
        XCTAssert(dt!.day == res.day)
        XCTAssert(dt!.hour == res.hour)
        XCTAssert(res.minute == dt!.minute + 1)
        XCTAssert(res.second == 0)

        let delta2 = SRTimeDelta(second: 0, minute: 50)
        let res2 = dt! + delta2
        XCTAssert(dt!.year == res2.year)
        XCTAssert(dt!.month == res2.month)
        XCTAssert(dt!.day == res2.day)
        XCTAssert(res2.hour == dt!.hour + 1)
        XCTAssert(res2.minute == 12)
        XCTAssert(res2.second == 55)
    }
    
    func testDiffBetweenDates() {
        let now = NSDate()
        let fut = NSDate.generate(year: now.year, month: now.month, day: now.day, hour: now.hour+1, minute: now.minute, second: now.second, nanosecond: now.nanosecond)
        // TODO: Test Code cannot recognize my '-' operator overloads from NSDate Extension.
        // Test with next Xcode and change testing method using overloads
        // let dif = fut! - now
        let secs = fut!.timeIntervalSinceDate(now)
        let dif = SRTimeDelta(interval: secs)

        println("diff = \(dif.description)")
        XCTAssert(Int(dif.interval) == 60*60)
        XCTAssert(dif.second == 0)
        XCTAssert(dif.hour == 1)
    }
}
