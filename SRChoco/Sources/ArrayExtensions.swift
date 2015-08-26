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
    
    // NOTE: func containString() has been deprecated. Use Array.contains() on Swift 2
}