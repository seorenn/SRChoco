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
    
func canLaunchApp(appScheme: String) -> Bool {
    if let appURL = NSURL(string: appScheme) {
        return UIApplication.sharedApplication().canOpenURL(appURL)
    } else {
        return false
    }
}

func launchApp(appScheme: String) {
    if let appURL = NSURL(string: appScheme) {
        UIApplication.sharedApplication().openURL(appURL)
    }
}

#elseif os(OSX)

// MARK: SRExternalApp for OSX

import Cocoa

func getAppPath(bundleIdentifier: String) -> String? {
    return NSWorkspace.sharedWorkspace().absolutePathForAppBundleWithIdentifier(bundleIdentifier)
}
    
func launchApp(appPath: String, arguments: [String]) -> NSTask! {
    let task = NSTask()
    task.launchPath = appPath
    task.arguments = arguments

    task.launch()
    return task
}
    
func launchApp(appPath: String) {
    NSWorkspace.sharedWorkspace().launchApplication(appPath)
}

func activateApp(pid: pid_t) {
    if let app = NSRunningApplication(processIdentifier: pid) {
        activateApp(app)
    }
}
    
func activateApp(bundleIdentifier: String) {
    let apps = NSRunningApplication.runningApplicationsWithBundleIdentifier(bundleIdentifier)
    if let app = apps.first {
        activateApp(app)
    }
}
    
func activateApp(app: NSRunningApplication) {
    app.activateWithOptions(.ActivateAllWindows)
}
    
#endif
