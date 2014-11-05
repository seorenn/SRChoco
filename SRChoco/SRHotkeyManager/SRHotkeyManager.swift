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

typealias SRHotkeyHandler = (hotkey: SRHotkey) -> ()

class SRHotkey: NSObject, Printable {
    var command = false
    var control = false
    var option = false
    var shift = false
    var keycode: UInt32 = 0
    var handler: SRHotkeyHandler?
    
    init(keycode: UInt32, command: Bool, control: Bool, option: Bool, shift: Bool, handler: SRHotkeyHandler) {
        self.keycode = keycode
        self.command = command
        self.control = control
        self.option = option
        self.shift = shift
        self.handler = handler
        super.init()
    }
    
    override var description: String {
        var modifiers: [String] = []
        
        if self.command { modifiers.append("Command") }
        if self.control { modifiers.append("Control") }
        if self.option { modifiers.append("Option") }
        if self.shift { modifiers.append("Shift") }
        
        var modifiersString = ""
        if modifiers.count > 0 {
            modifiersString = modifiers.stringByJoining("+")
        }
        
        return "<SRHotkey \(modifiersString) [\(self.keycode)]"
    }
    
    var modifiers: UInt32 {
        var value: UInt32 = 0
        if self.command { value += cmdKey }
        if self.control { value += controlKey }
        if self.option { value += optionKey }
        if self.shift { value += shiftKey }
        
        return value
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