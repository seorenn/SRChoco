//
// SRFile.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

class SRFile: NSObject, DebugPrintable, Equatable {
    
    // MARK: - Properties
    
    var path: String
    var name: String
    var parentDirectory: SRDirectory?
    
    var data: NSData? {
        get {
            if !self.exists { return nil }
            let fm = NSFileManager.defaultManager()
            return fm.contentsAtPath(self.path)
        }
        set {
            if self.exists && newValue != nil {
                newValue!.writeToFile(self.path, atomically: true)
            }
        }
    }
    
    var exists: Bool {
        let fm = NSFileManager.defaultManager()
        return fm.fileExistsAtPath(self.path)
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
        
        let fm = NSFileManager.defaultManager()
        if fm.createFileAtPath(self.path, contents: nil, attributes: nil) == false { return false }
        
        if data != nil {
            self.data = data
        }
        
        return true
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

// MARK: - Operator Overloads

func == (left: SRFile, right: SRFile) -> Bool {
    return left.path == right.path
}