import Foundation

extension NSDate {
    var dateComponents: (year:Int, month:Int, day:Int, hour:Int, minute:Int, second:Int) {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: self)
        return (year: components.year, month: components.month, day: components.day, hour: components.hour, minute: components.minute, second: components.second)
    }
}
