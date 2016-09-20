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

open class SRDevice {
  
  public static let current = SRDevice()
  
  open class var physicalMemory: UInt64 {
    return ProcessInfo.processInfo.physicalMemory
  }
  
  open class var physicalMemoryGigaBytes: Float {
    return Float(SRDevice.physicalMemory) / 1073741824.0
  }
  
  #if os(OSX)
  open class var OSXVersion: OperatingSystemVersion {
    return ProcessInfo.processInfo.operatingSystemVersion
  }
  
  open class var OSXVersionString: String {
    return ProcessInfo.processInfo.operatingSystemVersionString
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
