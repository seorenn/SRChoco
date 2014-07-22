import Foundation

func runTestNSDateExtensions() {
    let dt = NSDate()
    let dc = dt.dateComponents
    
    let calendar = NSCalendar.currentCalendar()
    let components = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: dt)
    
    assert(dc.year == components.year)
    assert(dc.month == components.month)
    assert(dc.day == components.day)
    assert(dc.hour == components.hour)
    assert(dc.minute == components.minute)
    assert(dc.second == components.second)
    
    println("NSDateExtensions: Passed all tests");
}
