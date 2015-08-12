//
// Log.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

private let g_logSharedInstance = Log()

// Xcode 7 Beta 5 Bug Fix
// NOTE: Please Remove this if not required in future xcode releases.
private extension String {
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
}

public class Log : CustomDebugStringConvertible {
    private let dateFormatter = NSDateFormatter()
    private let dispatchQueue = SRDispatchQueue.serialQueue("com.seorenn.srchoco.srlog")
    
    // Currently, Swift not support class var or class static var
    // class let Debug = "DEBUG"
    // class let Error = "ERROR"
    // class let Info = "INFO"

    // Singleton Instance
    public static let sharedLog: Log = Log()
    
    private func renderMessage(message: String, type: String, file: String, function: String, line: Int, putDatetime: Bool = false) -> String {
        let filename = file.lastPathComponent
        if putDatetime {
            let dateFormat = dateFormatter.stringFromDate(NSDate())
            return "\(dateFormat) [[\(type)] \(filename):\(line) \(function)] \(message)"
        } else {
            return "[[\(type)] \(filename):\(line) \(function)] \(message)"
        }
    }
    
    private func logToConsole(message: String, type: String, file: String, function: String, line: Int) {
        self.dispatchQueue.async() {
            [unowned self] in
            NSLog(self.renderMessage(message, type: type, file: file, function: function, line: line, putDatetime: false))
        }
    }
    
    public class func debug(message: String, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
        #if DEBUG
            Log.sharedLog.logToConsole(message, type: "DEBUG", file: file, function: function, line: line)
        #else
        #endif
    }

    public class func error(message: String, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
        Log.sharedLog.logToConsole(message, type: "ERROR", file: file, function: function, line: line)
    }

    public var debugDescription: String {
        get {
            return "<Log>"
        }
    }
    
    public init() {
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
}
