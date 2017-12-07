//
// SRExternalApp.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//


#if os(iOS)
  
  // MARK: SRExternalApp for iOS
  
  import UIKit
  
  public func canLaunchApp(appScheme: String) -> Bool {
    if let appURL = URL(string: appScheme) {
      return UIApplication.shared.canOpenURL(appURL)
    } else {
      return false
    }
  }
  
  public func launchApp(appScheme: String) {
    if let appURL = URL(string: appScheme) {
      if #available(iOS 10.0, *) {
        UIApplication.shared.open(appURL, options: [:]) { (succeed) in
          // TDOO
        }
      } else {
        // Fallback on earlier versions
        UIApplication.shared.openURL(appURL)
      }
    }
  }
  
#elseif os(OSX)
  
  // MARK: SRExternalApp for OSX
  
  import Cocoa
  
  public func getAppPath(bundleIdentifier: String) -> String? {
    return NSWorkspace.shared.absolutePathForApplication(withBundleIdentifier: bundleIdentifier)
  }
  
  public func launchApp(appPath: String, arguments: [String]) -> Process! {
    let task = Process()
    task.launchPath = appPath
    task.arguments = arguments
    
    task.launch()
    return task
  }
  
  public func launchApp(appPath: String) {
    NSWorkspace.shared.launchApplication(appPath)
  }
  
  public func activateApp(pid: pid_t) {
    if let app = NSRunningApplication(processIdentifier: pid) {
      activateApp(app: app)
    }
  }
  
  public func activateApp(bundleIdentifier: String) {
    let apps = NSRunningApplication.runningApplications(withBundleIdentifier: bundleIdentifier)
    if let app = apps.first {
      activateApp(app: app)
    }
  }
  
  public func activateApp(app: NSRunningApplication) {
    app.activate(options: NSApplication.ActivationOptions.activateAllWindows)
  }
  
#endif
