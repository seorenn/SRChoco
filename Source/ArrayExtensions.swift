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
        for (idx, item) in self.enumerated() {
            result += "\(item)"
            if idx < self.count - 1 {
                result += separator
            }
        }
        return result
    }
    
    // NOTE: func containString() has been deprecated. Use Array.contains() on Swift 2
    
    // Very good tweaks from: https://www.hackingwithswift.com/example-code/language/how-to-make-array-access-safer-using-a-custom-subscript
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        return self[index]
    }
    
    // Also good tweaks from: https://www.hackingwithswift.com/example-code/language/how-to-make-array-access-safer-using-a-custom-subscript
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
