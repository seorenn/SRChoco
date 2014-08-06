import Foundation

class SRDirectory: DebugPrintable, Equatable {
    var path: String?
    var name: String?
    var hidden = false
    var directories = Dictionary<String, SRDirectory>()
    var files = Dictionary<String, SRFile>()
    var loaded = false
    
    class func pathForUserDomain(directory: NSSearchPathDirectory) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(directory, NSSearchPathDomainMask.UserDomainMask, true)
        let path: String = paths[0] as String
        return path
    }
    
    class func pathURLForUserDomain(directory: NSSearchPathDirectory) -> NSURL {
        let fm = NSFileManager.defaultManager()
        let paths = fm.URLsForDirectory(directory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        return paths[0] as NSURL
    }
    
    class func pathForDownload() -> String {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.DownloadsDirectory)
    }
    
    class func pathForMovie() -> String {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.MoviesDirectory)
    }
    
    class func pathForHome() -> String {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        let home = NSProcessInfo.processInfo().environment
        let homePath: AnyObject? = home["HOME"]
        return homePath as String
    }
    
    init() {
        
    }
    
    convenience init(_ path: String) {
        self.init()
        self.path = path
    }
    
    convenience init(create: String) {
        self.init()
        // TODO
    }
    
    func load() {
        assert(self.path != nil)
        let fm = NSFileManager.defaultManager()
        var error: NSError?
        let contents = fm.contentsOfDirectoryAtPath(self.path, error: &error)
        
        self.files.removeAll(keepCapacity: false)
        self.directories.removeAll(keepCapacity: false)
        
        for content: AnyObject in contents {
            let name: String = content as String
            let fullPath = self.path! + "/" + name
            
            var isDirectory: ObjCBool = false
            let exists = fm.fileExistsAtPath(fullPath, isDirectory: &isDirectory)
            assert(exists)
            
            if isDirectory.boolValue {
                let dir = SRDirectory(fullPath)
                self.directories[name] = dir
            } else {
                let file = SRFile(fullPath)
                file.parentDirectory = self
                self.files[name] = file
            }
        }
        
        loaded = true
    }
    
    func load(block: (() -> ())) {
        SRDispatch.backgroundTask() {
            self.load()
            SRDispatch.mainTask() {
                block()
            }
        }
    }
    
    func createFile(path: String, data: NSData?) -> SRFile? {
        // TODO
        
        return nil
    }
    
    var debugDescription: String {
        if !loaded {
            return "<SRDirectory [\(path)] (not loaded)"
        } else {
            return "<SRDirectory [\(path)] containing \(self.directories.count) directories and \(self.files.count) files>"
        }
    }
}

func == (left: SRDirectory, right: SRDirectory) -> Bool {
    if left.path != nil && right.path != nil && left.path == right.path {
        return true
    }
    return false
}

// End of SRDirectory.swift