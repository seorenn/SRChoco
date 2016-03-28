//
// StringExtensions.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

public extension String {
    public var length: Int {
        return self.characters.count
    }

    public subscript(index: Int) -> Character {
        let chrIndex: String.CharacterView.Index
        
        if index >= 0 {
            chrIndex = self.characters.startIndex.advancedBy(index)
        } else {
            chrIndex = self.characters.startIndex.advancedBy(self.characters.count + index)
        }
        return self[chrIndex]
    }

    // substring with range
    public subscript(range: Range<Int>) -> String {
//        let start = advance(startIndex, range.startIndex, endIndex)
//        let end = advance(startIndex, range.endIndex, endIndex)
//        return self[start..<end]
        let start = self.startIndex.advancedBy(range.startIndex)
        let end = self.startIndex.advancedBy(range.endIndex)
        let range: Range<Index> = start..<end
        //return self.substringWithRange(Range<Index>(start: start, end: end))
        return self.substringWithRange(range)
    }
    
    // substring with NSRange
    public subscript(range: NSRange) -> String {
        if range.length <= 0 { return "" }
        let startIndex = range.location
        let endIndex = range.location + range.length - 1
        return self[startIndex...endIndex]
    }
    
    public func substring(startIndex: Int, length: Int) -> String {
        return self[startIndex ..< (startIndex + length)]
    }
    
    public func prefix(length: Int) -> String {
        return self.substring(0, length: length)
    }
    
    public func postfix(length: Int) -> String {
        let si: Int = self.characters.count - length
        return self.substring(si, length: length)
    }
    
    public func trimmedString() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    public func containString(string: String, ignoreCase: Bool = false) -> Bool {
        let options = ignoreCase ? NSStringCompareOptions.CaseInsensitiveSearch : NSStringCompareOptions()
        if let _ = self.rangeOfString(string, options: options) {
            return true
        }
        return false
    }
    
    public func containStrings(strings: Array<String>, ORMode: Bool = false, ignoreCase: Bool = false) -> Bool {
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
    
    public func arrayBySpliting(splitter: String? = nil) -> [String] {
        if let s = splitter {
            return self.componentsSeparatedByString(s)
        } else {
            return self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }

    internal static func stringWithCFStringVoidPointer(voidPtr: UnsafePointer<Void>) -> String? {
        let cfstr: CFStringRef = unsafeBitCast(voidPtr, CFStringRef.self)
        let nsstr: NSString = cfstr
        return nsstr as String
    }
}