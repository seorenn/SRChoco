//
// NSDateExtensions.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

private let DefaultISOFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"

// MARK: - SRTimeDelta

public struct SRTimeDelta: CustomStringConvertible {
    public let second: Int
    public let minute: Int
    public let hour: Int
    public let day: Int
    
    public var interval: NSTimeInterval {
        let seconds = self.second + (self.minute * 60) + (self.hour * 3600) + (self.day * 86400)
        return NSTimeInterval(seconds)
    }
    
    public init(second: Int = 0, minute: Int = 0, hour: Int = 0, day: Int = 0) {
        self.second = second
        self.minute = minute
        self.hour = hour
        self.day = day
    }
    
    public init(interval: NSTimeInterval) {
        var iv = Int(interval)
        
        self.day = iv / 86400
        iv = iv % 86400
        
        self.hour = iv / 3600
        iv = iv % 3600
        
        self.minute = iv / 60
        iv = iv % 60
        
        self.second = iv
    }
    
    public var description: String {
        return "<SRTimeDelta [\(self.interval)] second:\(self.second) minute:\(self.minute) hour:\(self.hour) day:\(self.day)>"
    }
}

// MARK: - NSDate Extensions

public extension NSDate {
    public var dateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int)? {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components([ .Year, .Month, .Day, .Hour, .Minute, .Second, .Nanosecond], fromDate: self)
            return (year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second, nanosecond: components.nanosecond)
        } else {
            return nil
        }
    }
    
    public var UTCDateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int)? {
        if let utccal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            if let tz = NSTimeZone(name: "UTC") {
                utccal.timeZone = tz
            } else {
                return nil
            }
            let components = utccal.components([ .Year, .Month, .Day, .Hour, .Minute, .Second, .Nanosecond ], fromDate: self)
            return (year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second, nanosecond: components.nanosecond)
        } else {
            return nil
        }
    }
    
    public var year: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components(.Year, fromDate: self)
            return components.year
        }
        return 0
    }
    public var month: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components(.Month, fromDate: self)
            return components.month
        }
        return 0
    }
    public var day: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components(.Day, fromDate: self)
            return components.day
        }
        return 0
    }
    public var hour: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components(.Hour, fromDate: self)
            return components.hour
        }
        return 0
    }
    public var minute: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components(.Minute, fromDate: self)
            return components.minute
        }
        return 0
    }
    public var second: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components(.Second, fromDate: self)
            return components.second
        }
        return 0
    }
    public var nanosecond: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components(.Nanosecond, fromDate: self)
            return components.nanosecond
        }
        return 0
    }
    
    // 1 based position index (based self's week)
    public var weekday: Int? {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components(.Weekday, fromDate: self)
            return components.weekday
        } else {
            return nil
        }
    }
    
    // total count of weeks (based self's month)
    public var countOfWeeks: Int? {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let range = calendar.rangeOfUnit(.WeekOfYear, inUnit: .Month, forDate: self)
            return range.length
        } else {
            return nil
        }
    }
    
    // 1 based position index (based self's month)
    public var weekOfMonth: Int? {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = calendar.components(.WeekOfMonth, fromDate: self)
            return components.weekOfMonth
        } else {
            return nil
        }
    }
    
    // localized name of day of week: eg. "Monday", "월요일", ...
    public var dayName: String {
        let f = NSDateFormatter()
        f.formatterBehavior = NSDateFormatterBehavior.Behavior10_4
        f.dateFormat = "EEEE"
        return f.stringFromDate(self)
    }
    
    public var daysOfMonth: Int? {
        if let dc = self.dateComponents {
            switch dc.month {
            case 1, 3, 5, 7, 8, 10, 12:
                return 31
            case 2:
                if dc.year % 4 == 0 {
                    return 29
                }
                return 28
            case 4, 6, 9, 11:
                return 30
            default:
                return 0
            }
        } else {
            return nil
        }
    }
    
    public class func generate(year year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int = 0) -> NSDate? {
        if let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) {
            let components = NSDateComponents()
            components.year = year
            components.month = month
            components.day = day
            components.hour = hour
            components.minute = minute
            components.second = second
            components.nanosecond = nanosecond
            
            return calendar.dateFromComponents(components)
        } else {
            return nil
        }
    }
    
    public class func generate(year year: Int, month: Int, day: Int) -> NSDate? {
        return NSDate.generate(year: year, month: month, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0)
    }
}

// MARK: - NSDate Comparison Operators
// NOTE: Future is bigger! :-)

public func == (left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedSame
}

public func > (left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedDescending
}

public func >= (left: NSDate, right: NSDate) -> Bool {
    let result = left.compare(right)
    return (result == NSComparisonResult.OrderedDescending || result == NSComparisonResult.OrderedSame)
}

public func < (left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedAscending
}

public func <= (left: NSDate, right: NSDate) -> Bool {
    let result = left.compare(right)
    return (result == NSComparisonResult.OrderedAscending || result == NSComparisonResult.OrderedSame)
}

// MARK: - NSDate Compution with SRTimeDelta

public func + (left: NSDate, right: SRTimeDelta) -> NSDate {
    return left.dateByAddingTimeInterval(right.interval)
}

public func - (left: NSDate, right: NSDate) -> SRTimeDelta {
    let secs = left.timeIntervalSinceDate(right)
    return SRTimeDelta(interval: secs)
}

public func - (left: NSDate, right: SRTimeDelta) -> NSDate {
    return left.dateByAddingTimeInterval(-right.interval)
}

