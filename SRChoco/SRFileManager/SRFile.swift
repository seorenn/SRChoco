import Foundation

class SRFile: DebugPrintable {
    var path: String?
    var data: NSData? {
        assert(path)
        let fm = NSFileManager.defaultManager()
        return fm.contentsAtPath(self.path)
    }
    var exists: Bool {
        assert(path)
        let fm = NSFileManager.defaultManager()
        return fm.fileExistsAtPath(path)
    }
    
    init() {
        
    }
    
    init(_ path: String) {
        self.path = path
    }
    
    var debugDescription: String {
        return "<SRFile: [\(path)]>"
    }
}

@infix func == (left: SRFile, right: SRFile) -> Bool {
    return left.path == right.path
}