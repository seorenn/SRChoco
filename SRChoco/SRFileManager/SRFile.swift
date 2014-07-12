import Foundation

class SRFile: DebugPrintable {
    var path: String?
    var data: NSData? {
        assert(self.path)
        let fm = NSFileManager.defaultManager()
        return fm.contentsAtPath(self.path)
    }
    
    init() {
        
    }
    
    init(_ path: String) {
        self.path = path
    }
    
    var debugDescription: String {
        // TODO
        return "<SRFile: [\(path)]>"
    }
}