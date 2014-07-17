import Foundation

class SRFile: DebugPrintable {
    var path: String?
    var parentDirectory: SRDirectory?
    var data: NSData? {
        get {
            assert(path)
            let fm = NSFileManager.defaultManager()
            return fm.contentsAtPath(self.path)
        }
        set {
            // TODO
        }
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
    
    func delete() -> Bool {
        // TODO
        
        return false
    }
    
    func moveToTrash() -> Bool {
        #if os(iOS)
            return false
        #endif
        
        // TODO
        
        return false
    }
    
    func moveTo(directory: SRDirectory) -> Bool {
        assert(directory.path)
        
        // TODO
        
        return false
    }
    
    var debugDescription: String {
        return "<SRFile: [\(path)]>"
    }
}

@infix func == (left: SRFile, right: SRFile) -> Bool {
    return left.path == right.path
}