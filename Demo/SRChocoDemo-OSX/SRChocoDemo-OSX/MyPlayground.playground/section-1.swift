import Cocoa



//import Carbon
//let iss = TISCreateInputSourceList(nil, Boolean(0))
//let cflist:CFArray = iss.takeUnretainedValue()
//let first = CFArrayGetValueAtIndex(cflist, 0)
//let firstTIS = UnsafePointer<TISInputSource>(first)
//let IDPtr = TISGetInputSourceProperty(TISInputSourceRef(first), kTISPropertyInputSourceID)

//let nsList = iss.takeUnretainedValue().__conversion()
//let first: AnyObject! = nsList.objectAtIndex(0)
//println("first = \(first)")
//let tis: TISInputSource = first as TISInputSource

//let IDPtr = TISGetInputSourceProperty(first, kTISPropertyInputSourceID)


let src = "this is test string for test"
let pat = "(test)"

var error: NSError?
let re = NSRegularExpression(pattern: pat, options: .CaseInsensitive, error: &error)

let matches = re.matchesInString(src, options: nil, range: NSMakeRange(0, countElements(src)))
matches.count

let conv = re.stringByReplacingMatchesInString(src, options: nil, range: NSMakeRange(0, countElements(src)), withTemplate: "->$1<-")

let now = NSDate()

let calendar = NSCalendar.currentCalendar()
let components = NSDateComponents()
components.year = 2014
components.month = 8
components.day = 10
components.hour = 12
components.minute = 12
components.second = 53

let future = calendar.dateFromComponents(components)
let result = now.compare(future)
if result == NSComparisonResult.OrderedAscending {
    println("ASC")
} else if result == NSComparisonResult.OrderedDescending {
    println("DEC")
} else {
    println("==")
}

func > (left: NSDate, right: NSDate) -> Bool {
    return left.compare(right) == NSComparisonResult.OrderedDescending
}
future > now

