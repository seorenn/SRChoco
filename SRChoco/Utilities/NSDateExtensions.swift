import Foundation

// MARK: - NSDate Extensions

extension NSDate {
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
}

// MARK: - NSDate Comparison Operators
// NOTE: Future is bigger! :-)

func == (left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedSame
}

func > (left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedDescending
}

func >= (left: NSDate, right: NSDate) -> Bool {
    let result = left.compare(right)
    return (result == NSComparisonResult.OrderedDescending || result == NSComparisonResult.OrderedSame)
    
}

func < (left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedAscending
}

func <= (left: NSDate, right: NSDate) -> Bool {
    let result = left.compare(right)
    return (result == NSComparisonResult.OrderedAscending || result == NSComparisonResult.OrderedSame)
    
}
