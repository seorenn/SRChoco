import Foundation

class SRFile: NSObject, DebugPrintable, Equatable {
    var path: String
    var parentDirectory: SRDirectory?
    var data: NSData? {
        get {
            let fm = NSFileManager.defaultManager()
            return fm.contentsAtPath(self.path)
        }
        set {
            // TODO
        }
    }
    var exists: Bool {
        let fm = NSFileManager.defaultManager()
        return fm.fileExistsAtPath(self.path)
    }
    
    init(_ path: String) {
        self.path = path
        super.init()
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
        // TODO
        
        return false
    }
    
    override var debugDescription: String {
        return "<SRFile: [\(path)]>"
    }
}

func == (left: SRFile, right: SRFile) -> Bool {
    return left.path == right.path
}