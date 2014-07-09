#if os(OSX)
import Cocoa
#endif
    
class SRWindowManager {
    // NOTE: Crashes on Xcode 6 beta 2
    func processes() -> [NSRunningApplication!] {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        let apps = NSWorkspace.sharedWorkspace().runningApplications
        return apps as [NSRunningApplication!]
    }

    func windowProcesses() -> Array<NSRunningApplication?> {
        var apps = Array<NSRunningApplication?>()
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        let list = CGWindowListCopyWindowInfo(CGWindowListOption(kCGWindowListExcludeDesktopElements | kCGWindowListOptionOnScreenOnly), CGWindowID(0))
        let windowInfos = list.takeRetainedValue().__conversion() as Array
        for info in windowInfos as Array<Dictionary<String, AnyObject>> {
            let pidPtr: AnyObject? = info[kCGWindowOwnerPID]
            let pidInt = pidPtr as Int
            let pid = CInt(pidInt)
            let app: NSRunningApplication? = NSRunningApplication(processIdentifier: pid)
            if app {
                apps.append(app)
            }
        }
        return apps
    }
}
