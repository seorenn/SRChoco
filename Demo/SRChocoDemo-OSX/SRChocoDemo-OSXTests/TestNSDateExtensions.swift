//
//  NSDateExtensionsTest.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 8. 6..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
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
        
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let components = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: now)
        
        XCTAssert(dc.year == components.year)
        XCTAssert(dc.month == components.month)
        XCTAssert(dc.day == components.day)
        XCTAssert(dc.hour == components.hour)
        XCTAssert(dc.minute == components.minute)
        XCTAssert(dc.second == components.second)
    }
    
    func testDateComparison() {
        let now = NSDate()
        let dc = now.dateComponents
        
        let nextYearDate = NSDate.generateWithYear(dc.year+1, month: dc.month, day: dc.day, hour: dc.hour, minute: dc.minute, second: dc.second)
        let prevYearDate = NSDate.generateWithYear(dc.year-1, month: dc.month, day: dc.day, hour: dc.hour, minute: dc.minute, second: dc.second)
        
        XCTAssert(now < nextYearDate)
        XCTAssert(nextYearDate > now)
        XCTAssert(now == now)
        XCTAssert(now > prevYearDate)
        XCTAssert(prevYearDate < now)
    }

}
