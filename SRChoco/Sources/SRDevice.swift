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

public class SRDevice {
    public class var physicalMemory: UInt64 {
        return NSProcessInfo.processInfo().physicalMemory
    }
    
    public class var physicalMemoryGigaBytes: Float {
        return Float(SRDevice.physicalMemory) / 1073741824.0
    }
    
    #if os(OSX)
    public class var OSXVersion: NSOperatingSystemVersion {
        return NSProcessInfo.processInfo().operatingSystemVersion
    }
    
    public class var OSXVersionString: String {
        return NSProcessInfo.processInfo().operatingSystemVersionString
    }
    #endif
    
    #if os(iOS)
    public class var iOSVersion: Float {
        let verStr = UIDevice.currentDevice().systemVersion as NSString
        return verStr.floatValue
    }
    
    public class var iOSVersionString: String {
        return UIDevice.currentDevice().systemVersion
    }
    #endif
}