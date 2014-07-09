import Foundation

class SRDirectory: DebugPrintable {
    var path: String?
    var name: String?
    var hidden = false
    var directories = Dictionary<String, SRDirectory>()
    var files = Dictionary<String, SRFile>()
    
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
        assert(self.path)
        let fm = NSFileManager.defaultManager()
        var error: NSError?
        let contents = fm.contentsOfDirectoryAtPath(self.path, error: &error)
        
        for content: AnyObject in contents {
            let name: String = content as String
            let fullPath = self.path! + "/" + name
            
            var isDirectory: ObjCBool = false
            let exists = fm.fileExistsAtPath(fullPath, isDirectory: &isDirectory)
            assert(exists)
            
            if isDirectory.getLogicValue() {
                let dir = SRDirectory(fullPath)
                self.directories[name] = dir
            } else {
                let file = SRFile(fullPath)
                self.files[name] = file
            }
        }
    }
    
    var debugDescription: String {
        return "<SRDirectory \(self.path) containing \(self.directories.count) directories and \(self.files.count) files>"
    }
}