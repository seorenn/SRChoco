//
// SRDirectory.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

class SRDirectory: NSObject, DebugPrintable, Equatable {
    
    // MARK: - Properties
    
    var path: String
    var name: String
    var hidden = false
    var directories = Dictionary<String, SRDirectory>()
    var files = Dictionary<String, SRFile>()
    var loaded = false
    
    var exists: Bool {
        let fm = NSFileManager.defaultManager()
        var isDir = ObjCBool(false)
        let res = fm.fileExistsAtPath(self.path, isDirectory: &isDir)
        
        if res && isDir.boolValue { return true }
        return false
    }
    
    // MARK: - Predefined
    
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
    
    // MARK: - Initializers
    
    init(_ path: String) {
        self.path = path
        self.name = self.path.lastPathComponent.stringByDeletingPathExtension
        super.init()
        
        if self.path[self.path.length - 1] == Character("/") {
            let last = self.path.length - 2
            self.path = self.path[0...last]
        }
    }
    
    convenience init(parentDirectory: SRDirectory, name: String) {
        let path = parentDirectory.path.stringByAppendingPathComponent(name)
        self.init(path)
    }
    
    init?(creatingPath: String, withIntermediateDirectories: Bool) {
        self.path = creatingPath
        self.name = self.path.lastPathComponent.stringByDeletingPathExtension
        super.init()
        
        if self.path[self.path.length - 1] == Character("/") {
            let last = self.path.length - 2
            self.path = self.path[0...last]
        }
        
        if self.create(intermediateDirectories: withIntermediateDirectories) == false { return nil }
    }
    
    // MARK: - Methods

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
                if let file = SRFile(fullPath) {
                    file.parentDirectory = self
                    self.files[name] = file
                }
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
    
    class func mkdir(path: String, withIntermediateDirectories: Bool) -> Bool {
        let fm = NSFileManager.defaultManager()
        var error: NSError?
        return fm.createDirectoryAtPath(path, withIntermediateDirectories: withIntermediateDirectories, attributes: nil, error: &error)
    }
    
    func create(intermediateDirectories: Bool = false) -> Bool {
        if self.exists { return true }

        let fm = NSFileManager.defaultManager()
        var error: NSError?
        return fm.createDirectoryAtPath(self.path, withIntermediateDirectories: intermediateDirectories, attributes: nil, error: &error)
    }
    
    func rename(name: String) -> Bool {
        // TODO
        return false
    }
    
    func move(directory: SRDirectory) -> Bool {
        // TODO
        return false
    }
    
    func createFile(name: String, data: NSData?, overwrite: Bool = false) -> SRFile? {
        if self.exists == false { return nil }
        if let file = SRFile(directory: self, name: name) {
            if file.exists == false {
                file.create(nil)
                file.data = data
            } else {
                if data != nil && overwrite {
                    file.data = data
                }
            }
            return file
        }
        return nil
    }
    
    func trash(removingAllSubContents: Bool = false) -> Bool {
        let url = NSURL(fileURLWithPath: self.path, isDirectory: true)
        if url == nil { return false }
        
        let fm = NSFileManager.defaultManager()
        
        if removingAllSubContents == false {
            if self.loaded == false { self.load() }
            if self.files.count > 0 || self.directories.count > 0 { return false }
        }

        var error: NSError?
        return fm.trashItemAtURL(url!, resultingItemURL: nil, error: &error)
    }
    
    func trashAllSubContents(stopWhenError: Bool, completion: (succeed: Bool) -> Void) {
        SRDispatch.backgroundTask() {
            var result = true
            if self.loaded == false { self.load() }
        
            for (name: String, dir: SRDirectory) in self.directories {
                let res = dir.trash(removingAllSubContents: true)
                if res == false {
                    result = false
                    if stopWhenError {
                        SRDispatch.mainTask() {
                            completion(succeed: false)
                        }
                        return
                    }
                }
            }
            for (name: String, file: SRFile) in self.files {
                let res = file.trash()
                if res == false {
                    result = false
                    if stopWhenError {
                        SRDispatch.mainTask() {
                            completion(succeed: false)
                        }
                        return
                    }
                }
            }
            
            SRDispatch.mainTask() {
                completion(succeed: result)
            }
        }
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
    if left.path == right.path { return true }
    return false
}

// End of SRDirectory.swift