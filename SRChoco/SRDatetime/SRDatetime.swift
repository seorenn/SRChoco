import Foundation

class SRDatetime {
    class var ISOFormat: String {
        return "yyyy-MM-dd'T'HH:mm:ssZZZ"
    }
    
    var year = 0
    var month = 0
    var day = 0
    var hour = 0
    var minute = 0
    var second = 0
    
    var date: NSDate {
        set {
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(NSCalendarUnit.CalendarUnitYear |
                                                 NSCalendarUnit.CalendarUnitMonth |
                                                 NSCalendarUnit.CalendarUnitDay |
                                                 NSCalendarUnit.CalendarUnitHour |
                                                 NSCalendarUnit.CalendarUnitMinute |
                                                 NSCalendarUnit.CalendarUnitSecond,
                                                 fromDate: newValue)
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
    
    init(date: NSDate) {
        self.date = date
    }
    
    convenience init(year:Int, month:Int, day:Int) {
        self.init(year:year, month:month, day:day, hour:0, minute:0, second:0)
    }
    
    convenience init(ISODatetimeString: String) {
        var str = ISODatetimeString
        if !ISODatetimeString.rangeOfString("+") {
            str = str + "+0000"
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = SRDatetime.ISOFormat
        
        self.init(date: formatter.dateFromString(str))
    }
    
    convenience init() {
        self.init(date: NSDate())
    }
}