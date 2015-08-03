SRChoco
=======

Seorenn's Something Special(?) Frameworks for Cocoa(AppKit) and Cocoa Touch(UIKit).

NOTE: I will separate some modules to independent project. SRChoco now refactoring. ;-)

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

# SRExternalApp

Helper Module for External Application

TODO: Need more documentation

# SRRegexp

Regular Expression Modules (likely Python's RE module)

TODO: Need more documentation

# SRStatusItemPopupController

TODO: This class will be seperating to independent framework project

The Controller for NSStatusItem with NSPopover components.

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

TODO: This class will be seperating to independent framework project

Simple Classes for Managing The Application Windows.

# SRUUID

Simple Class to generate the UUID.

TODO: Need more documentation

## SRStartupLauncher

Implementations of 'Launch at Login'.

TODO

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

# Branched Projects

* SRFile: https://github.com/seorenn/SRFile
* SRWindowManager: https://github.com/seorenn/SRWindowManager (Public version is developing with new interfaces)
* SRTextInputSourceManager: https://github.com/seorenn/SRTextInputSourceManager
* SRHotKeyManager: https://github.com/seorenn/SRHotKeyManager
