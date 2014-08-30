import Foundation

class SRFile: DebugPrintable, Equatable {
    var path: String?
    var parentDirectory: SRDirectory?
    var data: NSData? {
        get {
            assert(path != nil)
            let fm = NSFileManager.defaultManager()
            return fm.contentsAtPath(self.path!)
        }
        set {
            // TODO
        }
    }
    var exists: Bool {
        assert(path != nil)
        let fm = NSFileManager.defaultManager()
        return fm.fileExistsAtPath(path!)
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
        assert(directory.path != nil)
        
        // TODO
        
        return false
    }
    
    var debugDescription: String {
        return "<SRFile: [\(path)]>"
    }
}

func == (left: SRFile, right: SRFile) -> Bool {
    return left.path == right.path
}