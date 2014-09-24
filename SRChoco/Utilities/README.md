# Log

<pre>
Log.debug("blah blah")
Log.error("Wow! super foo bar!")
</pre>

# NSDateExtensions

<pre>
let now = NSDate()
let date = now.dateComponents!
println("\(date.year) - \(date.month) - \(date.day), \(date.hour):\(date.minute):\(date.second)")

let generatedDate = NSDate.generate(year:2014, month:10, day:24, hour:12, minute:25, second:59)!

if date == generatedDate {
    println("date is same with generatedDate")
} else if date > generatedDate {
    println("date is later than generatedDate")
} else {
    println("date is earlier than generatedDate")
}
</pre>

# ArrayExtensions

<pre>
// Join String Array
let inputArray = [ "This", "is", "test" ]
let outputString = inputArray.stringByJoining(" ")   // "This is test"
</pre>

# StringExtensions

<pre>
// Subscript String
let string = "123 ABC abc-"
println(str[0])      // Character("1")
println(str[1])      // Character("2")
println(str[-1])     // Character("-")
println(str[-2])     // Character("c")

// Substring
let substring = string[1...3]      // "23 "

// Trim
let trimmedString = string.trimmedString()

// Check Containing
if string.containString("ABC") {
    // ...
}

// Split
"This is test".arrayBySpliting()    // [ "This", "is", "test" ]
"1,2,3".arrayBySpliting(",")        // [ "1", "2", "3" ]
</pre>

# ViewExtensions

<pre>
let view = UIView()
view.x
view.y
view.width
view.height
view.origin         // CGPoint or NSPoint
view.size           // CGSize of NSSize
view.conterPoint    // CGPoint or NSPoint
view.moveToBelow(view: anotherView, margin: 5.0)
</pre>
