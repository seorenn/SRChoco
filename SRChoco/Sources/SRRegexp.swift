//
// SRRegexp.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//


import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


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
    return self.range(index: index)
  }
  
  public func string(index: Int) -> String {
    let range = self.range(index: index)
    let result = self.text[range]
    return result
  }
  
  public func range(index: Int) -> NSRange {
    let result = self.results.rangeAt(index)
    return result
  }
}

public struct SRRegexp {
  fileprivate let re: NSRegularExpression
  
  // MARK: Initializers
  
  public init?(_ pattern: String, ignoreCase: Bool = true) {
    var options: NSRegularExpression.Options = .useUnicodeWordBoundaries
    if ignoreCase { options = [ .useUnicodeWordBoundaries, .caseInsensitive ] }
    
    guard let re = try? NSRegularExpression(pattern: pattern, options: options)
      else { return nil }
    self.re = re
  }
  
  // MARK: Functions
  
  public func find(fromString: String) -> SRRegexpGroups? {
    let matches = self.re.matches(
      in: fromString,
      options: NSRegularExpression.MatchingOptions(),
      range: NSMakeRange(0, fromString.characters.count))
    guard let result = matches.first else { return nil }
    return SRRegexpGroups(results: result, text: fromString)
  }
  
  public func test(string: String) -> Bool {
    let matches = self.find(fromString: string)
    return matches != nil && matches?.count > 0
  }
  
  public func replace(fromString: String, template: String) -> String {
    return self.re.stringByReplacingMatches(
      in: fromString,
      options: NSRegularExpression.MatchingOptions(),
      range: NSMakeRange(0, fromString.characters.count),
      withTemplate: template)
  }
}
