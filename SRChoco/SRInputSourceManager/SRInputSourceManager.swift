
#if os(OSX)

import Cocoa

class SRInputSource {
    var selectable: Bool?
    var name: String?
    var inputSourceID: String?
    var iconURL: NSURL?
    var index: Int?
    
    private init(_ TISInfo: SRTISInfo?, _ TISIndex: Int) {
        selectable = TISInfo?.selectable
        name = TISInfo?.name
        inputSourceID = TISInfo?.inputSourceID
        iconURL = TISInfo?.iconURL
        index = TISIndex
    }
}

class SRInputSourceManager {
    private let tis = SRTISBridge()
    var inputSources: [SRInputSource] = []
    
    var currentInputSourceIndex: Int? {
        let isinfo = self.tis.currentInputSource
        for inputSource: SRInputSource in self.inputSources {
            if isinfo.name == inputSource.name {
                return inputSource.index
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
        tis.refresh()
        let count = tis.count
        inputSources = []
    
        for i in 0..<tis.count {
            let obj = SRInputSource(tis.infoAtIndex(i), i)
            inputSources.append(obj)
        }
    }
    
    func switchInputSource(inputSource: SRInputSource) {
        self.tis.switchTISAtIndex(inputSource.index!)
    }
}

#endif
