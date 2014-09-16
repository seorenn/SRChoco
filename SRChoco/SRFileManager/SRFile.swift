import Foundation

class SRFile: NSObject, DebugPrintable, Equatable {
    var path: String
    var parentDirectory: SRDirectory?
    var data: NSData? {
        get {
            if !self.exists { return nil }
            let fm = NSFileManager.defaultManager()
            return fm.contentsAtPath(self.path)
        }
        set {
            if self.exists {
                // TODO
            }
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
        if !self.exists { return false }
        
        // TODO
        return false
    }
    
    func moveToTrash() -> Bool {
        #if os(iOS)
            return false
        #else
            if !self.exists { return false }
            
            // TODO
            return false
        #endif
    }
    
    func moveTo(directory: SRDirectory) -> Bool {
        if !self.exists { return false }
        // TODO
        return false
    }
    
    override var debugDescription: String {
        let existance = self.exists ? "" : " (Not Exists)"
        return "<SRFile: [\(path)]\(existance)>"
    }
}

func == (left: SRFile, right: SRFile) -> Bool {
    return left.path == right.path
}