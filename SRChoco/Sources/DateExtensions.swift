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
  
  public var interval: TimeInterval {
    return TimeInterval(self.second)
  }
  
  public init(second: Int = 0) {
    self.second = second
  }
  
  public init(minute: Int) {
    self.init(second: minute * 60)
  }
  
  public init(interval: TimeInterval) {
    self.init(second: Int(interval))
  }
  
  public var description: String {
    return "<SRTimeDelta [\(self.interval)] second:\(self.second) minute:\(self.minute) hour:\(self.hour) day:\(self.day)>"
  }
}

// MARK: - NSDate Extensions

public extension Date {
  
  // Formats
  
  public func string(format: String) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format
    
    return formatter.string(from: self)
  }
  
  
  // Components
  
  public var dateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int)? {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents(
      [ .year, .month, .day, .hour, .minute, .second, .nanosecond],
      from: self)
    return (
      year: components.year!,
      month: components.month!,
      day: components.day!,
      hour: components.hour!,
      minute: components.minute!,
      second: components.second!,
      nanosecond: components.nanosecond!)
  }
  
  public var UTCDateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int)? {
    var utccal = Calendar(identifier: Calendar.Identifier.gregorian)
    if let tz = TimeZone(identifier: "UTC") {
      utccal.timeZone = tz
    } else {
      return nil
    }
    let components = utccal.dateComponents([ .year, .month, .day, .hour, .minute, .second, .nanosecond ], from: self)
    return (
      year: components.year!,
      month: components.month!,
      day: components.day!,
      hour: components.hour!,
      minute: components.minute!,
      second: components.second!,
      nanosecond: components.nanosecond!)
  }
  
  public var year: Int {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents([.year], from: self)
    return components.year!
  }
  
  public var month: Int {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents([.month], from: self)
    return components.month!
  }
  
  public var day: Int {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents([.day], from: self)
    return components.day!
  }
  
  public var hour: Int {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents([.hour], from: self)
    return components.hour!
  }
  
  public var minute: Int {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents([.minute], from: self)
    return components.minute!
  }
  
  public var second: Int {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents([.second], from: self)
    return components.second!
  }
  
  public var nanosecond: Int {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents([.nanosecond], from: self)
    return components.nanosecond!
  }
  
  // 1 based position index (based self's week)
  public var weekday: Int? {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents([.weekday], from: self)
    return components.weekday
  }
  
  // total count of weeks (based self's month)
  /* NOTE: FIX LATER. range.length is unresolved
  public var countOfWeeks: Int? {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let range = calendar.range(of: .weekOfYear, in: .month, for: self)
    return range.length
  }
 */
  
  // 1 based position index (based self's month)
  public var weekOfMonth: Int? {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    let components = calendar.dateComponents([.weekOfMonth], from: self)
    return components.weekOfMonth
  }
  
  // localized name of day of week: eg. "Monday", "월요일", ...
  public var dayName: String {
    let f = DateFormatter()
    f.formatterBehavior = DateFormatter.Behavior.behavior10_4
    f.dateFormat = "EEEE"
    return f.string(from: self)
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
  
  public static func generate(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int = 0) -> Date? {
    let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.second = second
    components.nanosecond = nanosecond
    
    return calendar.date(from: components)
  }
  
  public static func generate(year: Int, month: Int, day: Int) -> Date? {
    return Date.generate(year: year, month: month, day: day, hour: 0, minute: 0, second: 0, nanosecond: 0)
  }
}

// MARK: - NSDate Comparison Operators
// NOTE: Future is bigger! :-)

public func == (left: Date, right: Date) -> Bool {
  return left.compare(right) == ComparisonResult.orderedSame
}

public func > (left: Date, right: Date) -> Bool {
  return left.compare(right) == ComparisonResult.orderedDescending
}

public func >= (left: Date, right: Date) -> Bool {
  let result = left.compare(right)
  return (result == ComparisonResult.orderedDescending || result == ComparisonResult.orderedSame)
}

public func < (left: Date, right: Date) -> Bool {
  return left.compare(right) == ComparisonResult.orderedAscending
}

public func <= (left: Date, right: Date) -> Bool {
  let result = left.compare(right)
  return (result == ComparisonResult.orderedAscending || result == ComparisonResult.orderedSame)
}

// MARK: - NSDate Compution with SRTimeDelta

public func + (left: Date, right: SRTimeDelta) -> Date {
  return left.addingTimeInterval(right.interval)
}

public func - (left: Date, right: Date) -> SRTimeDelta {
  let secs = left.timeIntervalSince(right)
  return SRTimeDelta(interval: secs)
}

public func - (left: Date, right: SRTimeDelta) -> Date {
  return left.addingTimeInterval(-right.interval)
}

