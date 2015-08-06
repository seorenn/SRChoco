//
// ArrayExtensions.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

public extension Array {
    public func stringByJoining(separator: String) -> String {
        var result = ""
        for (idx, item) in self.enumerate() {
            result += "\(item)"
            if idx < self.count - 1 {
                result += separator
            }
        }
        return result
    }
    
    public func containString(string: String, ignoreCase: Bool = false) -> Bool {
        //let options = ignoreCase ? NSStringCompareOptions.CaseInsensitiveSearch : NSStringCompareOptions()

        for item in self {
            let s: String = item as! String
            if ignoreCase {
                if s.lowercaseString == string.lowercaseString { return true }
            } else {
                if s == string { return true }
            }
        }
        
        return false
    }
}