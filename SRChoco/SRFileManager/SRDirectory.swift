//
// SRDirectory.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

public class SRDirectory: DebugPrintable, Equatable {
    
    // MARK: - Private Properties
    
    private var dirty = true
    private var directoriesData = [String:SRDirectory]()
    private var filesData = [String:SRFile]()
    private let fm = NSFileManager.defaultManager()
    
    // MARK: - Properties
    
    public var path: String
    public var name: String
    
    
    public var directories: [String:SRDirectory] {
        if self.dirty {
            self.dirty = true
            self.load()
        }
        return self.directoriesData
    }
    
    public var files: [String:SRFile] {
        if self.dirty {
            self.dirty = true
            self.load()
        }
        return self.filesData
    }
    
    public var exists: Bool {
        var isDir = ObjCBool(false)
        let res = self.fm.fileExistsAtPath(self.path, isDirectory: &isDir)
        
        if res && isDir.boolValue { return true }
        return false
    }
    
    // MARK: - Predefined
    
    public class func pathForUserDomain(directory: NSSearchPathDirectory) -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(directory, NSSearchPathDomainMask.UserDomainMask, true)
        if paths == nil { return nil }
        return paths.last as? String
    }
    
    public class func pathURLForUserDomain(directory: NSSearchPathDirectory) -> NSURL? {
        let fm = NSFileManager.defaultManager()
        let paths = fm.URLsForDirectory(directory, inDomains: NSSearchPathDomainMask.UserDomainMask)
        return paths.last as? NSURL
    }
    
    public class var pathForDownloads: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.DownloadsDirectory)
    }
    
    public class var pathForMovies: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.MoviesDirectory)
    }
    
    public class var pathForDesktop: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.DesktopDirectory)
    }
    
    public class var pathForHome: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        let home = NSProcessInfo.processInfo().environment
        let homePath: AnyObject? = home["HOME"]
        return homePath as? String
    }
    
    public class var pathForApplicationSupports: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.ApplicationSupportDirectory)
    }
    
    public class var pathForCaches: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.CachesDirectory)
    }
    
    public class var pathForDocuments: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return SRDirectory.pathForUserDomain(.DocumentDirectory)
    }
    
    public class var pathForMainBundle: String? {
        #if os(iOS)
            assert(false, "iOS(UIKit) does not support this feature")
        #endif
        return NSBundle.mainBundle().resourcePath
    }
    
    public class var pathForTemporary: String? {
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
    
    public init(_ path: String) {
        self.path = path
        self.name = self.path.lastPathComponent.stringByDeletingPathExtension

        if self.path[self.path.length - 1] == Character("/") {
            let last = self.path.length - 2
            self.path = self.path[0...last]
        }
    }
    
    public convenience init(parentDirectory: SRDirectory, name: String) {
        let path = parentDirectory.path.stringByAppendingPathComponent(name)
        self.init(path)
    }
    
    public init?(creatingPath: String, withIntermediateDirectories: Bool) {
        self.path = creatingPath
        self.name = self.path.lastPathComponent.stringByDeletingPathExtension
        
        if self.path[self.path.length - 1] == Character("/") {
            let last = self.path.length - 2
            self.path = self.path[0...last]
        }
        
        if self.create(intermediateDirectories: withIntermediateDirectories) == false { return nil }
    }

    // MARK: - Methods

    private func load() {
        var error: NSError?
        let contents = fm.contentsOfDirectoryAtPath(self.path, error: &error)
        
        self.filesData.removeAll(keepCapacity: false)
        self.directoriesData.removeAll(keepCapacity: false)
        
        for content: AnyObject in contents! {
            let name: String = content as! String
            let fullPath = self.path + "/" + name
            
            var isDirectory: ObjCBool = false
            let exists = self.fm.fileExistsAtPath(fullPath, isDirectory: &isDirectory)
            
            if isDirectory.boolValue {
                let dir = SRDirectory(fullPath)
                self.directoriesData[name] = dir
            } else {
                if let file = SRFile(fullPath) {
                    file.parentDirectory = self
                    self.filesData[name] = file
                }
            }
        }
    }
    
//    class func mkdir(path: String, withIntermediateDirectories: Bool = false) -> Bool {
//        let fm = NSFileManager.defaultManager()
//        var error: NSError?
//        return fm.createDirectoryAtPath(path, withIntermediateDirectories: withIntermediateDirectories, attributes: nil, error: &error)
//    }
//    
//    class func mv(fromPath: String, toPath: String, withIntermediateDirectories: Bool = false) -> Bool {
//        let fm = NSFileManager.defaultManager()
//        var error: NSError?
//        
//        return fm.moveItemAtPath(fromPath, toPath: toPath, error: &error)
//    }
    
    public func create(intermediateDirectories: Bool = false) -> Bool {
        if self.exists { return true }

        var error: NSError?
        return self.fm.createDirectoryAtPath(self.path, withIntermediateDirectories: intermediateDirectories, attributes: nil, error: &error)
    }

    private func resetPath(path: String) {
        self.path = path
        // NOTE: Implement more codes if needed
    }
    
    public func rename(name: String) -> Bool {
        if name.containString("/") || self.exists == false { return false }
        
        let parentPath = self.path.stringByDeletingLastPathComponent
        let newPath = parentPath.stringByAppendingPathComponent(name)
        
        var error: NSError?
        let res = self.fm.moveItemAtPath(self.path, toPath: newPath, error: &error)
        if res == false { return false }
    
        self.resetPath(newPath)
        return true
    }
    
    public func move(parentPath: String) -> Bool {
        let myName = self.path.lastPathComponent
        let newPath = parentPath.stringByAppendingPathComponent(myName)
        
        var error: NSError?
        let res = self.fm.moveItemAtPath(self.path, toPath: newPath, error: &error)
        if res == false { return false }
        
        self.resetPath(newPath)
        return true
    }
    
    public func move(parentDirectory: SRDirectory) -> Bool {
        return self.move(parentDirectory.path)
    }
    
    public func createFile(name: String, data: NSData?, overwrite: Bool = false) -> SRFile? {
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
    
    public func trash() -> Bool {
#if os(iOS)
        return false
#else
        let url = NSURL(fileURLWithPath: self.path, isDirectory: true)
        if url == nil { return false }

        var error: NSError?
        let res = self.fm.trashItemAtURL(url!, resultingItemURL: nil, error: &error)
        if res {
            self.filesData.removeAll(keepCapacity: false)
            self.directoriesData.removeAll(keepCapacity: false)
        }
    
        return res
#endif
    }
    
    public var debugDescription: String {
        return "<SRDirectory [\(path)] containing \(self.directories.count) directories and \(self.files.count) files>"
    }
}

public func == (left: SRDirectory, right: SRDirectory) -> Bool {
    if left.path == right.path { return true }
    return false
}

// End of SRDirectory.swift