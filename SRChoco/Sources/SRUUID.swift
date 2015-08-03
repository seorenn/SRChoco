//
// SRUUID.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

public class SRUUID: CustomStringConvertible {
    private let UUIDString: String
    
    public init() {
        let uuid: CFUUIDRef = CFUUIDCreate(nil)
        self.UUIDString = CFUUIDCreateString(nil, uuid) as String
    }
    
    public var normalizedString: String {
        let lowercased = self.UUIDString.lowercaseString
        let hypenRemoved = lowercased.stringByReplacingOccurrencesOfString("-", withString: "")
        return hypenRemoved
    }
    
    public var rawString: String {
        return self.UUIDString
    }
    
    public var description: String {
        return self.UUIDString
    }
}