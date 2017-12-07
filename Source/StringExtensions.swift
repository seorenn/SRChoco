//
// StringExtensions.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

public extension String {
    
    public subscript(index: Int) -> Character {
        let chrIndex: String.Index
        
        if index >= 0 {
            chrIndex = self.index(self.startIndex, offsetBy: index)
        } else {
            chrIndex = self.index(self.endIndex, offsetBy: index)
        }
        return self[chrIndex]
    }
    
    // substring with range
    public subscript(range: Range<Int>) -> String {
        let start = self.index(self.startIndex, offsetBy: range.lowerBound)
        let end = self.index(self.startIndex, offsetBy: range.upperBound)
        let range: Range<Index> = start..<end
        return String(self[range])
    }
    
    // substring with NSRange
    public subscript(range: NSRange) -> String {
        if range.length <= 0 { return "" }
        let startIndex = range.location
        let endIndex = range.location + range.length
        return self[startIndex..<endIndex]
    }
    
    public func substring(startIndex: Int, length: Int) -> String {
        return self[startIndex ..< (startIndex + length)]
    }
    
    public func prefix(length: Int) -> String {
        return self.substring(startIndex: 0, length: length)
    }
    
    public func postfix(length: Int) -> String {
        let si: Int = self.count - length
        return self.substring(startIndex: si, length: length)
    }
    
    public func trimmedString() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    public func contain(string: String, ignoreCase: Bool = false) -> Bool {
        let options = ignoreCase ? NSString.CompareOptions.caseInsensitive : NSString.CompareOptions()
        if let _ = self.range(of: string, options: options) {
            return true
        }
        return false
    }
    
    public func contain(strings: Array<String>, ORMode: Bool = false, ignoreCase: Bool = false) -> Bool {
        for string: String in strings {
            if ORMode && self.contain(string: string, ignoreCase: ignoreCase) {
                return true
            } else if ORMode == false && self.contain(string: string, ignoreCase: ignoreCase) == false {
                return false
            }
        }
        
        if ORMode {
            return false
        } else {
            return true
        }
    }
    
    public func array(bySplitter: String? = nil) -> [String] {
        if let s = bySplitter {
            return self.components(separatedBy: s)
        } else {
            return self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    internal static func stringWithCFStringVoidPointer(_ voidPtr: UnsafeRawPointer) -> String? {
        let cfstr: CFString = unsafeBitCast(voidPtr, to: CFString.self)
        let nsstr: NSString = cfstr
        return nsstr as String
    }
}

public extension Optional where Wrapped == String {
    public var isNilOrEmpty: Bool {
        if self == nil { return true }
        return self!.isEmpty
    }
}
