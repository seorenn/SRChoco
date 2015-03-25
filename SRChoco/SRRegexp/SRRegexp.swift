//
// SRRegexp.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//


import Foundation

public struct SRRegexpGroups {
    public let text: String
    public let results: NSTextCheckingResult
    public var count: Int {
        return self.results.numberOfRanges
    }
    
    public init(results: NSTextCheckingResult, text: String) {
        self.text = text
        self.results = results
    }
    
    public subscript(index: Int) -> NSRange {
        return self.range(index)
    }
    
    public func string(index: Int) -> String {
        let range = self.range(index)
        let result = self.text[range]
        return result
    }
    
    public func range(index: Int) -> NSRange {
        let result = self.results.rangeAtIndex(index)
        return result
    }
}

public struct SRRegexp {
    private let re: NSRegularExpression?
    
    // MARK: Initializers
    
    public init?(_ pattern: String, ignoreCase: Bool = true) {
        var error: NSError?
        var options: NSRegularExpressionOptions = NSRegularExpressionOptions.UseUnicodeWordBoundaries
        if ignoreCase { options |= NSRegularExpressionOptions.CaseInsensitive }
        
        self.re = NSRegularExpression(pattern: pattern, options: options, error: &error)

        if self.re == nil { return nil }
    }
    
    // MARK: Functions
    
    public func find(string: String) -> SRRegexpGroups? {
        let matches = self.re?.matchesInString(string, options: NSMatchingOptions(0), range: NSMakeRange(0, countElements(string)))
        
        if matches?.count > 0 {
            let results = matches! as [NSTextCheckingResult]
            return SRRegexpGroups(results: results[0], text: string)
        } else {
            return nil
        }
    }
    
    public func test(string: String) -> Bool {
        let matches = self.find(string)
        return (matches != nil && matches?.count > 0)
    }
    
    public func replace(string: String, template: String) -> String {
        return re!.stringByReplacingMatchesInString(string, options: nil, range: NSMakeRange(0, countElements(string)), withTemplate: template)
    }
}