#if os(OSX)
    
import Cocoa
    
class SRWindowManager {
    // NOTE: Crashes on Xcode 6 beta 2
    func processes() -> NSRunningApplication[]! {
        let apps = NSWorkspace.sharedWorkspace().runningApplications
        return apps as NSRunningApplication[]!
    }
    
    // NOTE: Crashes on Xcode 6 beta 2
    func windowProcesses() -> AnyObject[]! {
        let list = CGWindowListCopyWindowInfo(CGWindowListOption(kCGWindowListOptionOnScreenOnly), CGWindowID(0))
        let windowInfos = list.takeRetainedValue().__conversion()
        return windowInfos
    }
}

#endif
