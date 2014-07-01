#if os(OSX)
import Cocoa
#endif
    
class SRWindowManager {
//    // NOTE: Crashes on Xcode 6 beta 2
//    func processes() -> NSRunningApplication[]! {
//        #if os(iOS)
//            assert(false, "iOS(UIKit) does not support this feature")
//        #endif
//        let apps = NSWorkspace.sharedWorkspace().runningApplications
//        return apps as NSRunningApplication[]!
//    }

    // NOTE: Crashes on Xcode 6 beta 2
    func windowProcesses() -> AnyObject[]! {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        let list = CGWindowListCopyWindowInfo(CGWindowListOption(kCGWindowListOptionOnScreenOnly), CGWindowID(0))
        let windowInfos = list.takeRetainedValue().__conversion() as Array
        //for info: Dictionary! in windowInfos {
        for info: AnyObject in windowInfos {
            let infoDict = info as Dictionary<String, AnyObject>
            let pidPtr = info[kCGWindowOwnerPID]
            let pid = pidPtr as Int

            println("test: pid = \(pid)\n\(infoDict)")
            
            //let app = NSRunningApplication(processIdentifier: pid)
        }
        return windowInfos
    }
}
