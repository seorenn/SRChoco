
#if os(OSX)
import Cocoa
#else
import Foundation
#endif

class SRInputSourceManager {
    let tis = SRTISBridge()
    
    struct StaticInstance {
        static var dispatchToken: dispatch_once_t = 0
        static var instance:SRInputSourceManager?
    }
    
    class func sharedManager() -> SRInputSourceManager {
        dispatch_once(&StaticInstance.dispatchToken) {
            StaticInstance.instance = SRInputSourceManager()
        }
        return StaticInstance.instance!
    }

    init() {
    }
}