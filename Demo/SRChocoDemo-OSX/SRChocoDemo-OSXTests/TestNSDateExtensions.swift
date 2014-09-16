//
//  NSDateExtensionsTest.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 8. 6..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

import Cocoa
import XCTest

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
        }
    }
    
    func testDateComparison() {
        let now = NSDate()
        let dc = now.dateComponents!
        
        let nextYearDate = NSDate.generate(dc.year+1, month: dc.month, day: dc.day, hour: dc.hour, minute: dc.minute, second: dc.second)!
        let prevYearDate = NSDate.generate(dc.year-1, month: dc.month, day: dc.day, hour: dc.hour, minute: dc.minute, second: dc.second)!
        
        XCTAssert(now < nextYearDate)
        XCTAssert(nextYearDate > now)
        XCTAssert(now == now)
        XCTAssert(now > prevYearDate)
        XCTAssert(prevYearDate < now)
    }

    func testDateCreation() {
        let dt = NSDate.generate(1949, month: 7, day: 21, hour: 12, minute: 25, second: 59)!
        let dc = dt.dateComponents
        XCTAssertEqual(dc!.year, 1949)
        XCTAssertEqual(dc!.month, 7)
        XCTAssertEqual(dc!.day, 21)
        XCTAssertEqual(dc!.hour, 12)
        XCTAssertEqual(dc!.minute, 25)
        XCTAssertEqual(dc!.second, 59)
    }
}
