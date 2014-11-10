//
// SRHotKeyManager.swift
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

typealias SRHotKeyHandler = (hotKey: SRHotKey) -> ()

class SRHotKey: NSObject, Printable {
    var command = false
    var control = false
    var option = false
    var shift = false
    var keycode: UInt32 = 0
    var handler: SRHotKeyHandler?
    
    init(keycode: UInt32, command: Bool, control: Bool, option: Bool, shift: Bool, handler: SRHotKeyHandler) {
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
        
        return "<SRHotKey \(modifiersString) [\(self.keycode)]"
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

private func SRHotKeyHandleFunction(nextHandler: EventHandlerCallRef, theEvent: EventRef, userData: UnsafeMutablePointer<Void>) -> OSStatus {
    return noErr
}

class SRGlobalHotKeyManager: NSObject, Printable {
    private let signature = "srgh"
    
    // MARK: - Singleton Factory

    struct StaticInstance {
        static var dispatchToken: dispatch_once_t = 0
        static var instance: SRGlobalHotKeyManager?
    }
    
    class func sharedManager() -> SRGlobalHotKeyManager {
        dispatch_once(&StaticInstance.dispatchToken) {
            StaticInstance.instance = SRGlobalHotKeyManager()
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
        return "SRHotKeyManager"
    }

    // MARK: - Public Methods
    func registerHotKey(hotKey: SRHotKey) {
        var hotKeyRef: EventHotKeyRef
        var hotKeyId: EventHotKeyID
        var eventType: EventTypeSpec = EventTypeSpec(eventClass: OSType(kEventClassKeyboard), eventKind: OSType(kEventHotKeyPressed))
        
        let handlerClosure: (EventHandlerCallRef, EventRef, UnsafeMutablePointer<Void>) -> OSStatus = SRHotKeyHandleFunction
        
        InstallApplicationEventHandler(handlerClosure, 1, &eventType, nil, nil)
    }
}