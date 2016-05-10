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
  
  public var minute: Int {
    return self.second / 60
  }
  
  public var hour: Int {
    return self.second / 3600
  }
  
  public var day: Int {
    return self.second / 86400
  }
  
  public var year: Int {
    return self.second  / (86400 * 365)
  }
  
  public var interval: NSTimeInterval {
    return NSTimeInterval(self.second)
  }
  
  public init(second: Int = 0) {
    self.second = second
  }
  
  public init(minute: Int) {
    self.init(second: minute * 60)
  }
  
  public init(interval: NSTimeInterval) {
    self.init(second: Int(interval))
  }
  
  public var description: String {
    return "<SRTimeDelta [\(self.interval)] second:\(self.second) minute:\(self.minute) hour:\(self.hour) day:\(self.day)>"
  }
}

// MARK: - NSDate Extensions

public extension NSDate {
  
  // Formats
  
  public func string(format: String) -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat = format
    
    return formatter.stringFromDate(self)
  }
  
  
  // Components
  
  public var dateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int)? {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return nil }
    
    let components = calendar.components(
      [ .Year, .Month, .Day, .Hour, .Minute, .Second, .Nanosecond],
      fromDate: self)
    return (
      year: components.year,
      month: components.month,
      day: components.day,
      hour: components.hour,
      minute: components.minute,
      second: components.second,
      nanosecond: components.nanosecond)
  }
  
  public var UTCDateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int)? {
    guard let utccal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return nil }
    
    if let tz = NSTimeZone(name: "UTC") {
      utccal.timeZone = tz
    } else {
      return nil
    }
    let components = utccal.components([ .Year, .Month, .Day, .Hour, .Minute, .Second, .Nanosecond ], fromDate: self)
    return (
      year: components.year,
      month: components.month,
      day: components.day,
      hour: components.hour,
      minute: components.minute,
      second: components.second,
      nanosecond: components.nanosecond)
  }
  
  public var year: Int {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return 0 }
    
    let components = calendar.components(.Year, fromDate: self)
    return components.year
  }
  
  public var month: Int {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return 0 }
    
    let components = calendar.components(.Month, fromDate: self)
    return components.month
  }
  
  public var day: Int {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return 0 }
    
    let components = calendar.components(.Day, fromDate: self)
    return components.day
  }
  
  public var hour: Int {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return 0 }
    
    let components = calendar.components(.Hour, fromDate: self)
    return components.hour
  }
  
  public var minute: Int {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return 0 }
    
    let components = calendar.components(.Minute, fromDate: self)
    return components.minute
  }
  
  public var second: Int {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return 0 }
    
    let components = calendar.components(.Second, fromDate: self)
    return components.second
  }
  
  public var nanosecond: Int {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return 0 }
    
    let components = calendar.components(.Nanosecond, fromDate: self)
    return components.nanosecond
  }
  
  // 1 based position index (based self's week)
  public var weekday: Int? {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return nil }
    
    let components = calendar.components(.Weekday, fromDate: self)
    return components.weekday
  }
  
  // total count of weeks (based self's month)
  public var countOfWeeks: Int? {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return nil }
    
    let range = calendar.rangeOfUnit(.WeekOfYear, inUnit: .Month, forDate: self)
    return range.length
  }
  
  // 1 based position index (based self's month)
  public var weekOfMonth: Int? {
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return nil }
    
    let components = calendar.components(.WeekOfMonth, fromDate: self)
    return components.weekOfMonth
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
    guard let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
      else { return nil }
    
    let components = NSDateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.second = second
    components.nanosecond = nanosecond
    
    return calendar.dateFromComponents(components)
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

