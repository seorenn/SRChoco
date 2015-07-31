//
//  SRDevice.swift
//  SRChoco
//
//  Created by Seorenn on 2015. 2. 26..
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

#if os(iOS)
import UIKit
#else
import AppKit
#endif

class SRDevice {
    class var physicalMemory: UInt64 {
        return NSProcessInfo.processInfo().physicalMemory
    }
    
    class var physicalMemoryGigaBytes: Float {
        return Float(SRDevice.physicalMemory) / 1073741824.0
    }
    
    #if os(OSX)
    class var OSXVersion: NSOperatingSystemVersion {
        return NSProcessInfo.processInfo().operatingSystemVersion
    }
    
    class var OSXVersionString: String {
        return NSProcessInfo.processInfo().operatingSystemVersionString
    }
    #endif
    
    #if os(iOS)
    class var iOSVersion: Float {
        let verStr = UIDevice.currentDevice().systemVersion as NSString
        return verStr.floatValue
    }
    
    class var iOSVersionString: String {
        return UIDevice.currentDevice().systemVersion
    }
    #endif
}