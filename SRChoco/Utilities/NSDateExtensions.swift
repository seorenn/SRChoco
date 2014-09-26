import Foundation

private let DefaultISOFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"

// MARK: - SRTimeDelta

public struct SRTimeDelta: Printable {
    let second: Int
    let minute: Int
    let hour: Int
    let day: Int
    
    var interval: NSTimeInterval {
        let seconds = self.second + (self.minute * 60) + (self.hour * 3600) + (self.day * 86400)
        return NSTimeInterval(seconds)
    }
    
    init(second: Int = 0, minute: Int = 0, hour: Int = 0, day: Int = 0) {
        self.second = second
        self.minute = minute
        self.hour = hour
        self.day = day
    }
    
    init(interval: NSTimeInterval) {
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

extension NSDate: Comparable, Equatable {
    var dateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int)? {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond | NSCalendarUnit.CalendarUnitNanosecond, fromDate: self)
            return (year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second, nanosecond: components.nanosecond)
        } else {
            return nil
        }
    }
    
    var UTCDateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int)? {
        if let utccal = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            if let tz = NSTimeZone(name: "UTC") {
                utccal.timeZone = tz
            } else {
                return nil
            }
            let components = utccal.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond | NSCalendarUnit.CalendarUnitNanosecond, fromDate: self)
            return (year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second, nanosecond: components.nanosecond)
        } else {
            return nil
        }
    }
    
    var year: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.CalendarUnitYear, fromDate: self)
            return components.year
        }
        return 0
    }
    var month: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.CalendarUnitMonth, fromDate: self)
            return components.month
        }
        return 0
    }
    var day: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.CalendarUnitDay, fromDate: self)
            return components.day
        }
        return 0
    }
    var hour: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.CalendarUnitHour, fromDate: self)
            return components.hour
        }
        return 0
    }
    var minute: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.CalendarUnitMinute, fromDate: self)
            return components.minute
        }
        return 0
    }
    var second: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.CalendarUnitSecond, fromDate: self)
            return components.second
        }
        return 0
    }
    var nanosecond: Int {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.CalendarUnitNanosecond, fromDate: self)
            return components.nanosecond
        }
        return 0
    }
    
    // 1 based position index (based self's week)
    var weekday: Int? {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: self)
            return components.weekday
        } else {
            return nil
        }
    }
    
    // total count of weeks (based self's month)
    var countOfWeeks: Int? {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let range = calendar.rangeOfUnit(NSCalendarUnit.WeekCalendarUnit, inUnit: NSCalendarUnit.MonthCalendarUnit, forDate: self)
            return range.length
        } else {
            return nil
        }
    }
    
    // 1 based position index (based self's month)
    var weekOfMonth: Int? {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
            let components = calendar.components(NSCalendarUnit.WeekOfMonthCalendarUnit, fromDate: self)
            return components.weekOfMonth
        } else {
            return nil
        }
    }
    
    // localized name of day of week: eg. "Monday", "월요일", ...
    var dayName: String {
        let f = NSDateFormatter()
        f.formatterBehavior = NSDateFormatterBehavior.Behavior10_4
        f.dateFormat = "EEEE"
        return f.stringFromDate(self)
    }
    
    var daysOfMonth: Int? {
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
    
    public class func generate(#year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int, nanosecond: Int = 0) -> NSDate? {
        if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
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
    
    public class func generate(#year: Int, month: Int, day: Int) -> NSDate? {
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

public func - (left: NSDate, right: SRTimeDelta) -> NSDate {
    return left.dateByAddingTimeInterval(-right.interval)
}

public func - (left: NSDate, right: NSDate) -> SRTimeDelta {
    let secs = left.timeIntervalSinceDate(right)
    return SRTimeDelta(interval: secs)
}