
#if os(OSX)
import Cocoa
#else
import Foundation
#endif

public class SRInputSource {
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

public class SRInputSourceManager {
    private let tis = SRTISBridge()
    var inputSources: [SRInputSource] = []
    
    var currentInputSourceIndex: Int? {
        #if os(OSX)
            let isinfo = self.tis.currentInputSource
            for inputSource: SRInputSource in self.inputSources {
                if isinfo.name == inputSource.name {
                    return inputSource.index
                }
            }
            return nil
        #else
            return nil
        #endif
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
        #if os(OSX)
            tis.refresh()
            let count = tis.count
            inputSources = []
        
            for i in 0..<tis.count {
                let obj = SRInputSource(tis.infoAtIndex(i), i)
                inputSources.append(obj)
            }
        #endif
    }
    
    func switchInputSource(inputSource: SRInputSource) {
        #if os(OSX)
            self.tis.switchTISAtIndex(inputSource.index!)
        #endif
    }
}