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
    private let re: NSRegularExpression
    
    // MARK: Initializers
    
    public init?(_ pattern: String, ignoreCase: Bool = true) {
        var options: NSRegularExpressionOptions = .UseUnicodeWordBoundaries
        if ignoreCase { options = [ .UseUnicodeWordBoundaries, .CaseInsensitive ] }
        
        guard let re = try? NSRegularExpression(pattern: pattern, options: options)
            else { return nil }
        self.re = re
    }
    
    // MARK: Functions
    
    public func find(string: String) -> SRRegexpGroups? {
        let matches = self.re.matchesInString(
            string,
            options: NSMatchingOptions(),
            range: NSMakeRange(0, string.characters.count))
        guard let result = matches.first else { return nil }
        return SRRegexpGroups(results: result, text: string)
    }
    
    public func test(string: String) -> Bool {
        let matches = self.find(string)
        return matches != nil && matches?.count > 0
    }
    
    public func replace(string: String, template: String) -> String {
        return self.re.stringByReplacingMatchesInString(
            string,
            options: NSMatchingOptions(),
            range: NSMakeRange(0, string.characters.count),
            withTemplate: template)
    }
}