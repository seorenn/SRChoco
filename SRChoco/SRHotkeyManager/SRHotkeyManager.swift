//
// SRHotkeyManager.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

#if os(OSX)
import AppKit
import Carbon
#else
import Foundation
#endif

class SRHotkey: NSObject, Printable {
    override init() {
        // TODO
        super.init()
    }
    
    override var description: String {
        // TODO
        return "SRHotkey"
    }
}

class SRHotkeyManager: NSObject, Printable {
    private let signature = "srhm"
    
    // MARK: - Singleton Factory

    struct StaticInstance {
        static var dispatchToken: dispatch_once_t = 0
        static var instance: SRHotkeyManager?
    }
    
    class func sharedManager() -> SRHotkeyManager {
        dispatch_once(&StaticInstance.dispatchToken) {
            StaticInstance.instance = SRHotkeyManager()
        }
        return StaticInstance.instance!
    }
    
    // MARK: - Initializers
    override init() {
        // TODO
        super.init()
    }
    
    override var description: String {
        // TODO
        return "SRHotkeyManager"
    }

    // MARK: - Public Methods

}