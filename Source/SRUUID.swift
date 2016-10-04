//
// SRUUID.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

open class SRUUID: CustomStringConvertible {
  fileprivate let UUIDString: String
  
  public init() {
    let uuid: CFUUID = CFUUIDCreate(nil)
    self.UUIDString = CFUUIDCreateString(nil, uuid) as String
  }
  
  open var normalizedString: String {
    let lowercased = self.UUIDString.lowercased()
    let hypenRemoved = lowercased.replacingOccurrences(of: "-", with: "")
    return hypenRemoved
  }
  
  open var rawString: String {
    return self.UUIDString
  }
  
  open var description: String {
    return self.UUIDString
  }
}
