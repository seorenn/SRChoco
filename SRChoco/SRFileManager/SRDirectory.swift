//
// SRDirectory.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

class SRDirectory: NSObject, DebugPrintable, Equatable {
    var path: String
    var name: String
    var hidden = false
    var directories = Dictionary<String, SRDirectory>()
    var files = Dictionary<String, SRFile>()
    var loaded = false
    
    class func pathForUserDomain(directory: NSSearchPathDirectory) -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(directory, NSSearchPathDomainMask.UserDomainMask, true)
        if paths == nil { return nil }
        return paths.last as? String
    }
    
    class func pathURLForUserDomain(directory: NSSearchPathDirectory) -> NSURL? {
        let fm = NSFileManager.defaultManager()
        let paths = fm.URLsForDirectory(directory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        return paths.last as? NSURL
    }
    
    class var pathForDownloads: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.DownloadsDirectory)
    }
    
    class var pathForMovies: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.MoviesDirectory)
    }
    
    class var pathForHome: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        let home = NSProcessInfo.processInfo().environment
        let homePath: AnyObject? = home["HOME"]
        return homePath as? String
    }
    
    class var pathForApplicationSupports: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.ApplicationSupportDirectory)
    }
    
    class var pathForCaches: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.CachesDirectory)
    }
    
    class var pathForDocuments: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.DocumentDirectory)
    }
    
    class var pathForMainBundle: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return NSBundle.mainBundle().resourcePath
    }
    
    class var pathForTemporary: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        if let path = NSTemporaryDirectory() {
            return path
        } else {
            return nil
        }
    }
    
    var exists: Bool {
        let fm = NSFileManager.defaultManager()
        var isDir = ObjCBool(false)
        fm.fileExistsAtPath(self.path, isDirectory: &isDir)
        
        if isDir.boolValue { return true }
        return false
    }
    
    init(_ path: String) {
        self.path = path
        // TODO: self.name
        self.name = "Unimplemented Property"
        super.init()
    }
    
    convenience init?(create path: String) {
        self.init(path)
        // TODO
        return nil
    }
    
    func load() {
        let fm = NSFileManager.defaultManager()
        var error: NSError?
        let contents = fm.contentsOfDirectoryAtPath(self.path, error: &error)
        
        self.files.removeAll(keepCapacity: false)
        self.directories.removeAll(keepCapacity: false)
        
        for content: AnyObject in contents! {
            let name: String = content as String
            let fullPath = self.path + "/" + name
            
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
    
    class func mkdir(path: String, intermediateDirectories: Bool) -> Bool {
        let fm = NSFileManager.defaultManager()
        var error: NSError?
        return fm.createDirectoryAtPath(path, withIntermediateDirectories: intermediateDirectories, attributes: nil, error: &error)
    }
    
    func create() -> Bool {
        // TODO
        return false
    }
    
    func createFile(path: String, data: NSData?) -> SRFile? {
        // TODO
        
        return nil
    }
    
    override var debugDescription: String {
        if !loaded {
            return "<SRDirectory [\(path)] (not loaded)"
        } else {
            return "<SRDirectory [\(path)] containing \(self.directories.count) directories and \(self.files.count) files>"
        }
    }
}

func == (left: SRDirectory, right: SRDirectory) -> Bool {
    if left.path == right.path {
        return true
    }
    return false
}

// End of SRDirectory.swift