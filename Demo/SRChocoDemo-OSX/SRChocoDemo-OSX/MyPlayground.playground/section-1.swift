import Cocoa

//let apps = NSWorkspace.sharedWorkspace().runningApplications
//
//for obj: AnyObject in apps {
//    let app = obj as NSRunningApplication
//
//    println("\(app.ownsMenuBar) - \(app)")
//}

//let flag: UInt32 = kCGWindowListOptionOnScreenOnly | kCGWindowListExcludeDesktopElements

// crashes
//let list = CGWindowListCopyWindowInfo(CGWindowListOption(kCGWindowListOptionOnScreenOnly), CGWindowID(0))
//let windowInfo = list.takeRetainedValue().__conversion()



for i in 1..<5 {
    println(i)
}

let arr: [AnyObject] = [ "test", "test2" ]
for item in arr as [String] {
    println(item)
}