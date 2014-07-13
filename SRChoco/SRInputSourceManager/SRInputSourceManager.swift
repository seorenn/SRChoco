
import Cocoa
import Carbon

struct SRInputSource {
    var inputSourceID: String?
    var TISObject: TISInputSourceRef?
    var name: String?
    var iconURL: NSURL?
    var enabled = false
    
    init(_ TISInputSourceObject: TISInputSourceRef) {
        let enabledPtr = TISGetInputSourceProperty(TISInputSourceObject, kTISPropertyInputSourceIsEnabled)
        self.enabled = enabledPtr.getLogicValue()
        
        let IDPtr = TISGetInputSourceProperty(TISInputSourceObject, kTISPropertyInputSourceID)
    }
}

class SRInputSourceManager {
    var inputSources: [TISInputSourceRef]?
    
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
        self.inputSources = self.getInputSourceList()
    }
    
    func getInputSourceList() -> [TISInputSourceRef] {
        let iss = TISCreateInputSourceList(nil, Boolean(0))
        let nsList = iss.takeRetainedValue() as NSArray
        let list = nsList as [TISInputSourceRef]
        return list
    }
}