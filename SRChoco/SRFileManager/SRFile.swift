//
// SRFile.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

class SRFile: NSObject, DebugPrintable, Equatable {
    
    // MARK: - Configurations
    
    private let delayForFileWriting: NSTimeInterval = 0.5
    private let fm = NSFileManager.defaultManager()
    
    // MARK: - Properties
    
    var path: String
    var name: String
    var parentDirectory: SRDirectory?
    
    var data: NSData? {
        get {
            if !self.exists { return nil }
            return self.fm.contentsAtPath(self.path)
        }
        set {
            if newValue != nil {
                newValue!.writeToFile(self.path, atomically: true)
            }
        }
    }
    
    var exists: Bool {
        return self.fm.fileExistsAtPath(self.path)
    }
    
    var extensionName: String {
        return self.name.pathExtension
    }
    
    var nameWithoutExtension: String {
        return self.name.stringByDeletingPathExtension
    }
    
    // MARK: - Initializers
    
    init?(_ path: String) {
        self.path = path
        self.name = self.path.lastPathComponent
        self.parentDirectory = SRDirectory(self.path.stringByDeletingLastPathComponent)
        super.init()
        
        if path[path.length-1] == Character("/") {
            return nil
        }
    }
    
    init?(directory: SRDirectory, name: String) {
        self.path = directory.path.stringByAppendingPathComponent(name)
        self.name = name
        self.parentDirectory = directory
        super.init()
        
        if name.containString("/") { return nil }
    }
    
    // MARK: - Methods
    
    func create(data: NSData?) -> Bool {
        if self.exists { return true }
        
        if self.fm.createFileAtPath(self.path, contents: nil, attributes: nil) == false { return false }
        
        if data != nil {
            self.data = data
        }
        
        return true
    }
    
    func trash() -> Bool {
        #if os(iOS)
            return false
        #else
            if !self.exists { return false }
            
            var error: NSError?
            if let fileURL = NSURL(fileURLWithPath: self.path) {
                return self.fm.trashItemAtURL(fileURL, resultingItemURL: nil, error: &error)
            }
            
            return false
        #endif
    }
    
    private func resetPath(path: String) {
        self.path = path
        self.name = self.path.lastPathComponent
        self.parentDirectory = SRDirectory(self.path.stringByDeletingLastPathComponent)
    }
    
    func rename(name: String) -> Bool {
        if name.containString("/") || self.exists == false { return false }
        
        if let directory = self.parentDirectory {
            let newPath = directory.path.stringByAppendingPathComponent(name)
            
            var error: NSError?
            let res = self.fm.moveItemAtPath(self.path, toPath: newPath, error: &error)
            if res == false { return false }
            
            self.resetPath(newPath)
            return true
        }

        return false
    }
    
    func moveTo(directoryPath: String) -> Bool {
        if let directory = self.parentDirectory {
            let newPath = directoryPath.stringByAppendingPathComponent(self.name)
            
            var error: NSError?
            let res = self.fm.moveItemAtPath(self.path, toPath: newPath, error: &error)
            if res == false { return false }
            
            self.resetPath(newPath)
            return true
        }
        
        return false
    }
    
    func moveTo(directory: SRDirectory) -> Bool {
        return self.moveTo(directory.path)
    }

    // Write to file with completion block (use this if you want to write a large file content)
    func write(data: NSData, completion: (succeed: Bool) -> Void) {
        SRDispatch.backgroundTask() {
            let res = data.writeToFile(self.path, atomically: true)
            
            // Waiting finish atomically working
            NSThread.sleepForTimeInterval(self.delayForFileWriting)

            // Call completion closure on main thread
            SRDispatch.mainTask() {
                completion(succeed: res)
            }
        }
    }
    
    func read(completion: (data: NSData?) -> Void) {
        SRDispatch.backgroundTask() {
            if self.exists {
                let readed = self.fm.contentsAtPath(self.path)
                SRDispatch.mainTask() {
                    completion(data: readed)
                }
            } else {
                SRDispatch.mainTask() {
                    completion(data: nil)
                }
            }
        }
    }
    
    override var debugDescription: String {
        let existance = self.exists ? "" : " (Not Exists)"
        return "<SRFile: [\(path)]\(existance)>"
    }
}

// MARK: - Operator Overloads

func == (left: SRFile, right: SRFile) -> Bool {
    return left.path == right.path
}