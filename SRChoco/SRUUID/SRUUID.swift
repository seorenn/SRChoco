//
// SRUUID.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

class SRUUID {
    // MARK: - Singleton Factory
    
    struct StaticInstance {
        static var dispatchToken: dispatch_once_t = 0
        static var instance: SRUUID?
    }
    
    class func defaultUUID() -> SRUUID {
        dispatch_once(&StaticInstance.dispatchToken) {
            StaticInstance.instance = SRUUID()
        }
        return StaticInstance.instance!
    }
    
    // MARK: - Properties
    
    var convertToLowercase: Bool = true
    var removeHyphen: Bool = true
    
    // MARK: - Initializers
    
    init() {
        
    }
    
    // MARK: - Methods
    
    func uuid() -> String {
        let uuid: CFUUIDRef = CFUUIDCreate(nil)
        let uuidString: String = CFUUIDCreateString(nil, uuid)
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