import Foundation

private let DefaultISOFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"

// MARK: - NSDate Extensions

public extension NSDate {
    var dateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let components = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: self)
        return (year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second)
    }
    
    var UTCDateComponents: (year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) {
        let utccal = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        utccal.timeZone = NSTimeZone(name: "UTC")
        let components = utccal.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: self)
        return (year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second)
    }
    
    // 1 based position index (based self's week)
    var weekday: Int {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let components = calendar.components(NSCalendarUnit.WeekdayCalendarUnit, fromDate: self)
        return components.weekday
    }
    
    // total count of weeks (based self's month)
    var countOfWeeks: Int {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let range = calendar.rangeOfUnit(NSCalendarUnit.WeekCalendarUnit, inUnit: NSCalendarUnit.MonthCalendarUnit, forDate: self)
        return range.length
    }
    
    // 1 based position index (based self's month)
    var weekOfMonth: Int {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let components = calendar.components(NSCalendarUnit.WeekOfMonthCalendarUnit, fromDate: self)
        return components.weekOfMonth
    }
    
    // localized name of day of week: eg. "Monday", "월요일", ...
    var dayName: String {
        let f = NSDateFormatter()
        f.formatterBehavior = NSDateFormatterBehavior.Behavior10_4
        f.dateFormat = "EEEE"
        return f.stringFromDate(self)
    }
    
    var daysOfMonth: Int {
        let dc = self.dateComponents
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
    }
    
    class func generate(year: Int, month: Int, day: Int, hour: Int, minute: Int, second: Int) -> NSDate? {
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.second = second
        
        return calendar.dateFromComponents(components)
    }
    
    class func generate(year: Int, month: Int, day: Int) -> NSDate? {
        return NSDate.generate(year, month: month, day: day, hour: 0, minute: 0, second: 0)
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
