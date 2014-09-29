//
// ArrayExtensions.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

extension Array {
    func stringByJoining(seperator: String) -> String {
        var result = ""
        for (idx, item) in enumerate(self) {
            result += "\(item)"
            if idx < self.count - 1 {
                result += seperator
            }
        }
        return result
    }
    
    func containString(string: String, ignoreCase: Bool = false) -> Bool {
        let options = ignoreCase ? NSStringCompareOptions.CaseInsensitiveSearch : NSStringCompareOptions.allZeros

        for item in self {
            let s: String = item as String
            if ignoreCase {
                if s.lowercaseString == string.lowercaseString { return true }
            } else {
                if s == string { return true }
            }
        }
        
        return false
    }
}