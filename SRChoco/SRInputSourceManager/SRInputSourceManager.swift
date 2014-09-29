//
// SRInputSourceManager.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

#if os(OSX)

import Cocoa
import Carbon
    
extension Bool {
    static func boolFromCFBooleanVoidPointer(voidPtr: UnsafePointer<Void>) -> Bool? {
        let cfbool: CFBooleanRef = unsafeBitCast(voidPtr, CFBooleanRef.self)
        let boolValue: Bool = cfbool
        return boolValue
    }
}
    
extension NSURL {
    class func urlFromCFURLVoidPointer(voidPtr: UnsafePointer<Void>) -> NSURL? {
        let cfurl: CFURLRef = unsafeBitCast(voidPtr, CFURLRef.self)
        let url: NSURL = cfurl
        return url
    }
}
    
class SRInputSource: NSObject, Printable, Equatable {
    let name: String?
    let inputSourceID: String?
    let type: String?
    let selectable: Bool?
    let iconURL: NSURL?
    let tis: TISInputSourceRef?
    
    private init(_ tis: TISInputSourceRef) {
        self.tis = tis
        
        self.name = String.stringWithCFStringVoidPointer(TISGetInputSourceProperty(tis, kTISPropertyLocalizedName))
        self.inputSourceID = String.stringWithCFStringVoidPointer(TISGetInputSourceProperty(tis, kTISPropertyInputSourceID))
        self.type = String.stringWithCFStringVoidPointer(TISGetInputSourceProperty(tis, kTISPropertyInputSourceType))
        self.selectable = Bool.boolFromCFBooleanVoidPointer(TISGetInputSourceProperty(tis, kTISPropertyInputSourceIsSelectCapable))
        self.iconURL = NSURL.urlFromCFURLVoidPointer(TISGetInputSourceProperty(tis, kTISPropertyIconImageURL))
        
        super.init()
    }
    
    func activate() {
        if self.tis != nil {
            TISSelectInputSource(self.tis)
        }
    }
    
    var keyboardInputable: Bool {
        if let type = self.type {
            return (type == kTISTypeKeyboardLayout || type == kTISTypeKeyboardInputMode || type == kTISTypeKeyboardInputMethodModeEnabled)
        } else {
            return false
        }
    }
    
    override var description: String {
        let messages = [ "<SRInputSource> Name:\(self.name)",
                         "                Input Source ID: \(self.inputSourceID)",
                         "                Type: \(self.type)",
                         "                Selectable: \(self.selectable)",
                         "                Icon URL: \(self.iconURL)",
                         "                Keyboard Inputable: \(self.keyboardInputable)" ]
        return messages.stringByJoining("\n")
    }
}

func == (left: SRInputSource, right: SRInputSource) -> Bool {
    return left.inputSourceID == right.inputSourceID
}

class SRInputSourceManager {
    var inputSources: [SRInputSource] = []
    
    var currentInputSource: SRInputSource {
        let currentPtr = TISCopyCurrentKeyboardInputSource()
        let current: TISInputSourceRef = currentPtr.takeUnretainedValue()
        return SRInputSource(current)
    }
    
    var currentInputSourceIndex: Int? {
        let current = self.currentInputSource
        for (index, inputSource) in enumerate(self.inputSources) {
            if current == inputSource {
                return index
            }
        }
        return nil
    }
    
    // singleton instance type
    struct StaticInstance {
        static var dispatchToken: dispatch_once_t = 0
        static var instance:SRInputSourceManager?
    }
    
    // singleton factory
    class func sharedManager() -> SRInputSourceManager {
        dispatch_once(&StaticInstance.dispatchToken) {
            StaticInstance.instance = SRInputSourceManager()
        }
        return StaticInstance.instance!
    }

    init() {
        self.refresh()
    }
    
    // generate input source informations
    func refresh() {
        let iss = TISCreateInputSourceList(nil, Boolean(0))
        let issArray: CFArrayRef = iss.takeUnretainedValue()
        let issCount = CFArrayGetCount(issArray)
        
        inputSources = []
    
        for i in 0..<issCount {
            let tisVoidPtr = CFArrayGetValueAtIndex(issArray, i)
            let tis: TISInputSourceRef = unsafeBitCast(tisVoidPtr, TISInputSourceRef.self)
            
            let obj = SRInputSource(tis)
            if obj.keyboardInputable {
                inputSources.append(obj)
            }
        }
    }
    
    func switchInputSource(inputSource: SRInputSource) {
        inputSource.activate()
    }

    func switchInputSource(index: Int) {
        let inputSource = self.inputSources[index]
        self.switchInputSource(inputSource)
    }
}

#endif
