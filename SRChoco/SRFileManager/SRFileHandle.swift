//
// SRFileHandle.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2015 Seorenn. All rights reserved.
//

import Foundation

enum SRFileHandleMode {
    case Read, Write
}

class SRFileHandle: DebugPrintable {
    let path: String
    private let handle: NSFileHandle?
    private let mode: SRFileHandleMode
    
    init?(pathForReading: String) {
        path = pathForReading
        mode = .Read
        
        handle = NSFileHandle(forReadingAtPath: path)
        if handle == nil {
            return nil
        }
    }

    init?(pathForWriting: String) {
        path = pathForWriting
        mode = .Write
        
        handle = NSFileHandle(forWritingAtPath: path)
        if handle == nil {
            return nil
        }
    }

    deinit {
        close()
    }
    
    func close() {
        if let h = handle {
            h.closeFile()
        }
    }
    
    func text() -> String? {
        var error: NSError? = nil
        let result = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error)
        
        if error != nil { return nil }
        return result
    }
    
    func readline() -> String? {
        // TODO
        return nil
    }
    
    func readlines() -> [String] {
        var result = [String]()
        
        while let line = readline() {
            result.append(line)
        }
        
        return result
    }
    
    var debugDescription: String {
        return "<SRFileHandle: \(path)>"
    }
}

func open(path: String, mode: String) -> SRFileHandle? {
    if mode == "r" {
        return SRFileHandle(pathForReading: path)
    } else if mode == "w" {
        return SRFileHandle(pathForWriting: path)
    } else {
        return nil
    }
}