// Playground - noun: a place where people can play

import Cocoa

class SRDatetime {
    // class let isoFormat = "" // TODO
    var year = 0
    var month = 0
    var day = 0
    var hour = 0
    var minute = 0
    var second = 0
    
    var date: NSDate {
    set {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: newValue)
        self.year = components.year
        self.month = components.month
        self.day = components.day
        self.hour = components.hour
        self.minute = components.minute
        self.second = components.second
    }
    get {
        let calendar = NSCalendar.currentCalendar()
        let components = NSDateComponents()
        components.year = self.year
        components.month = self.month
        components.day = self.day
        components.hour = self.hour
        components.minute = self.minute
        components.second = self.second
        
        return calendar.dateFromComponents(components)
    }
    }
    
    init(year:Int, month:Int, day:Int, hour:Int, minute:Int, second:Int) {
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
    }
    
    convenience init(year:Int, month:Int, day:Int) {
        self.init(year:year, month:month, day:day, hour:0, minute:0, second:0)
    }
    
    init(date: NSDate) {
        self.date = date
    }
    
    // TODO
    // init(isoFormatString: String) {
    // }
    
    convenience init() {
        self.init(date: NSDate())
    }
}

var dt1 = SRDatetime()
dt1.year
dt1.month
dt1.day
dt1.hour
dt1.minute
dt1.second
dt1.date
