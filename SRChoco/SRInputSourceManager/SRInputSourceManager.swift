
#if os(OSX)

import Cocoa
import Carbon
    
class SRInputSource: Equatable {
    var selectable: Bool?
    var name: String?
    var inputSourceID: String?
    var iconURL: NSURL?
    var tis: TISInputSourceRef?
    
    private init(_ tis: TISInputSourceRef) {
        self.tis = tis
        
        // TODO: self.selectable
        self.name = String.stringWithCFStringVoidPointer(TISGetInputSourceProperty(tis, kTISPropertyLocalizedName))
        self.inputSourceID = String.stringWithCFStringVoidPointer(TISGetInputSourceProperty(tis, kTISPropertyInputSourceID))
        // TODO: self.iconURL
    }
    
    func activate() {
        if self.tis != nil {
            TISSelectInputSource(self.tis)
        }
    }
}

func == (left: SRInputSource, right: SRInputSource) -> Bool {
    return left.inputSourceID == right.inputSourceID
}

class SRInputSourceManager {
    var inputSources: [SRInputSource] = []
    
    var currentInputSource: SRInputSource {
        let currentPtr = TISCopyCurrentKeyboardInputSource()
        let current: TISInputSourceRef = currentPtr.takeUnretainedValue()
        return SRInputSource(current)
    }
    
    var currentInputSourceIndex: Int? {
        let current = self.currentInputSource
        for (index, inputSource) in enumerate(self.inputSources) {
            if current == inputSource {
                return index
            }
        }
        return nil
    }
    
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
        self.refresh()
    }
    
    func refresh() {
        let iss = TISCreateInputSourceList(nil, Boolean(0))
        let issArray: CFArrayRef = iss.takeUnretainedValue()
        let issCount = CFArrayGetCount(issArray)
        
        inputSources = []
    
        //for i in 0..<tis.count {
        for i in 0..<issCount {
            let tisVoidPtr = CFArrayGetValueAtIndex(issArray, i)
            let tis: TISInputSourceRef = unsafeBitCast(tisVoidPtr, TISInputSourceRef.self)
            
            let obj = SRInputSource(tis)
            inputSources.append(obj)
        }
    }
    
    func switchInputSource(inputSource: SRInputSource) {
        inputSource.activate()
    }

    func switchInputSource(index: Int) {
        let inputSource = self.inputSources[index]
        self.switchInputSource(inputSource)
    }
}

#endif
