//
// Log.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

class Log : DebugPrintable {
    let dateFormatter = NSDateFormatter()
    
    // Currently, Swift not support class var or class static var
    // class let Debug = "DEBUG"
    // class let Error = "ERROR"
    // class let Info = "INFO"
    
    struct staticInstance {
        static var instance: Log?
        static var dispatchToken: dispatch_once_t = 0
    }
    
    class func sharedObject() -> Log? {
        dispatch_once(&staticInstance.dispatchToken) {
            staticInstance.instance = Log()
        }
        return staticInstance.instance
    }
    
    func renderMessage(message: String, type: String, file: String, function: String, line: Int, putDatetime: Bool = false) -> String {
        if putDatetime {
            let dateFormat = dateFormatter.stringFromDate(NSDate())
            return "\(dateFormat) [[\(type)] \(file):\(line) \(function)] \(message)"
        } else {
            return "[[\(type)] \(file):\(line) \(function)] \(message)"
        }
    }
    
    func logToConsole(message: String, type: String, file: String, function: String, line: Int) {
        NSLog(renderMessage(message, type: type, file: file, function: function, line: line, putDatetime: false))
    }
    
    class func debug(message: String, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
        Log.sharedObject()?.logToConsole(message, type: "DEBUG", file: file, function: function, line: line)
    }

    class func error(message: String, file: String = __FILE__, function: String = __FUNCTION__, line: Int = __LINE__) {
        Log.sharedObject()?.logToConsole(message, type: "ERROR", file: file, function: function, line: line)
    }

    var debugDescription: String {
        get {
            return "<Log>"
        }
    }
    
    init() {
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
}