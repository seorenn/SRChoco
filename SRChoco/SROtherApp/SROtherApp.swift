#if os(iOS)

// MARK: SROtherApp for iOS
import UIKit
    
func canLaunchApp(appScheme: String) -> Bool {
    let appURL = NSURL.URLWithString(appScheme)
    return UIApplication.sharedApplication().canOpenURL(appURL)
}

func launchApp(appScheme: String) {
    let appURL = NSURL.URLWithString(appScheme)
    UIApplication.sharedApplication().openURL(appURL)
}

#elseif os(OSX)

// MARK: SROtherApp for OSX
import Cocoa

func getAppPath(bundleIdentifier: String) -> String {
    return NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier(bundleIdentifier)
}
    
func launchApp(appPath: String, arguments: [String]) -> NSTask! {
    let task = NSTask()
    task.launchPath = appPath
    task.arguments = arguments

    task.launch()
    return task
}
    
func launchApp(appPath: String) {
    NSWorkspace.sharedWorkspace().launchApplication(appPath)
}

func activateApp(pid: pid_t) {
    let app = NSRunningApplication(processIdentifier: pid)
    activateApp(app)
}
    
func activateApp(bundleIdentifier: String) {
    let apps = NSRunningApplication.runningApplicationsWithBundleIdentifier(bundleIdentifier)
    let app: NSRunningApplication! = apps[0] as NSRunningApplication
    activateApp(app)
}
    
func activateApp(app: NSRunningApplication) {
    app.activateWithOptions(.ActivateAllWindows)
}
    
#endif
