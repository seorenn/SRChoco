SRChoco
=======

Seorenn's Cocoa(AppKit) and Cocoa Touch(UIKit) Libraries.

# SRFileManager

Simple File System(?) Classes

## SRDirectory

Get Files and Directories on my HOME directory:
<pre>
let home = SRDirectory(SRDirectory.pathForHome())
home.load()

for dir: SRDirectory in home.directories {
    println(dir)
}

for file: SRFile in home.files {
    println(file)
}
</pre>

Asynchronous Load for Big File-system:
<pre>
let home = SRDirectory(SRDirectory.pathForHome())
home.load() {
    for dir: SRDirectory in home.directories {
        println(dir)
    }

    for file: SRFile in home.files {
        println(file)
    }
}
</pre>

# SRGCD

Grand Central Dispatch Helper Module

## Tasks

<pre>
SRDispatch.asyncTask() {
    ...
    SRDispatch.mainTask() {
        ...
    }
}

SRDispatch.backgroundTask() {
    ...
}
</pre>

# SRInputSourceManager

Simple Classes to manage Text Input Source

TODO: Need more documentation

# SRExternalApp

Helper Module for External Application

TODO: Need more documentation

# SRRegexp

Regular Expression Modules (likely Python's RE module)

TODO: Need more documentation

# SRStatusItemPopupController

The Controller for NSStatusItem with NSPopover components.

NOTE: This module supports OSX platform only.

## How to use

In your AppDelegate:

<pre>
class AppDelegate: NSObject, NSApplicationDelegate {
    // ...
    var statusItemPopupController: SRStatusItemPopupController?

    func applicationdidfinishlaunching(aNotification: NSNotification?) {
        // ...
        let viewController = MyViewController(nibName: "MyViewController", bundle: nil)
        let image = NSImage(name: "Icon")
        let alternateImage = NSImage(name: "Icon-Open")
        self.statusItemPopupController = SRStatusItemPopupController(viewController: viewController,
                                                                     image: image,
                                                                     alternateImage: alternateImage)
        // ...
    }
</pre>

# SRWindowManager

Simple Classes for Managing The Application Windows.

TODO: Need more documentation

# SRUUID

Simple Class to generate the UUID.

TODO: Need more documentation

# Utilities

Some utility classes and extensions for more conveniences...

## Log

<pre>
Log.debug("blah blah")
Log.error("Wow! super foo bar!")
</pre>

## NSDateExtensions

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

## ArrayExtensions

<pre>
// Join String Array
let inputArray = [ "This", "is", "test" ]
let outputString = inputArray.stringByJoining(" ")   // "This is test"
</pre>

## StringExtensions

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

## ViewExtensions

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
