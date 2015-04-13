//
// SRUUID.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

private let _uuidSharedInstance = SRUUID()

public class SRUUID {
    // MARK: - Singleton Factory
    
    public class func defaultUUID() -> SRUUID {
        return _uuidSharedInstance
    }
    
    // MARK: - Properties
    
    var convertToLowercase: Bool = true
    var removeHyphen: Bool = true
    
    // MARK: - Initializers
    
    public init() {
        
    }
    
    // MARK: - Methods
    
    public func uuid() -> String {
        let uuid: CFUUIDRef = CFUUIDCreate(nil)
        let uuidString: String = CFUUIDCreateString(nil, uuid) as String
        return self.transform(uuidString)
    }
    
    // MARK: - Private Methods
    
    private func transform(var input: String) -> String {
        if self.convertToLowercase {
            input = input.lowercaseString
        }
        if self.removeHyphen {
            input = input.stringByReplacingOccurrencesOfString("-", withString: "")
        }
        return input
    }
}