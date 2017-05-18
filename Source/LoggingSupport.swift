//
// LoggingSupport.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2017 Seorenn. All rights reserved.
//

import Foundation

public protocol LoggingSupport {
  var debugMode: Bool { get set }
}

public extension LoggingSupport {
  func L(_ message: String, function: String = #function) {
    guard debugMode else { return }
    
    let dt = Date().isoString
    print("\(dt) [\(function)] \(message)")
  }
}
