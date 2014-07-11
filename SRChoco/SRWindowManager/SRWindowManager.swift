#if os(OSX)
import Cocoa
    
class SRWindowManager {
    var capturing = false
    
    struct StaticInstance {
        static var dispatchToken: dispatch_once_t = 0
        static var instance:SRWindowManager?
    }
    
    class func sharedManager() -> SRWindowManager {
        dispatch_once(&StaticInstance.dispatchToken) {
            StaticInstance.instance = SRWindowManager()
        }
        return StaticInstance.instance!
    }
    
    func processes() -> [NSRunningApplication!] {
        let apps = NSWorkspace.sharedWorkspace().runningApplications
        return apps as [NSRunningApplication!]
    }

    func windowProcesses() -> Array<NSRunningApplication?> {
        var apps = Array<NSRunningApplication?>()
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
    
    func startCaptureWindowChanging() {
        if capturing {
            return
        }
    
        let notificationCenter = NSWorkspace.sharedWorkspace().notificationCenter;
        // TODO
    }
}
#endif
