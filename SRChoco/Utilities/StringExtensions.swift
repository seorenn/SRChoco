//
// StringExtensions.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

extension String {
    var length: Int {
        return count(self)
    }

    subscript(index: Int) -> Character {
        let elements = Array(self)
        if index >= 0 { return elements[index] }
        else {
            let revIndex = self.length + index
            return elements[revIndex]
        }
    }

    // substring with range
    subscript(range: Range<Int>) -> String {
        let start = advance(startIndex, range.startIndex, endIndex)
        let end = advance(startIndex, range.endIndex, endIndex)
        return self[start..<end]
    }
    
    // substring with NSRange
    subscript(range: NSRange) -> String {
        if range.length <= 0 { return "" }
        let startIndex = range.location
        let endIndex = range.location + range.length - 1
        return self[startIndex...endIndex]
    }
    
    func trimmedString() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func containString(string: String, ignoreCase: Bool = false) -> Bool {
        let options = ignoreCase ? NSStringCompareOptions.CaseInsensitiveSearch : NSStringCompareOptions.allZeros
        if let range = self.rangeOfString(string, options: options) {
            return true
        }
        return false
    }
    
    func containStrings(strings: Array<String>, ORMode: Bool = false, ignoreCase: Bool = false) -> Bool {
        for string: String in strings {
            if ORMode && self.containString(string, ignoreCase: ignoreCase) {
                return true
            } else if ORMode == false && self.containString(string, ignoreCase: ignoreCase) == false {
                return false
            }
        }
        
        if ORMode {
            return false
        } else {
            return true
        }
    }
    
    func arrayBySpliting(splitter: String? = nil) -> [String] {
        if let s = splitter {
            return self.componentsSeparatedByString(s)
        } else {
            return self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }

    static func stringWithCFStringVoidPointer(voidPtr: UnsafePointer<Void>) -> String? {
        let cfstr: CFStringRef = unsafeBitCast(voidPtr, CFStringRef.self)
        let nsstr: NSString = cfstr
        return nsstr as String
    }
}