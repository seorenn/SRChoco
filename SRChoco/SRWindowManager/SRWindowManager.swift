//
// SRWindowManager.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

#if os(OSX)

import Cocoa
    
class SRWindowManager {
    // singleton instance type
    struct StaticInstance {
        static var dispatchToken: dispatch_once_t = 0
        static var instance:SRWindowManager?
    }
    
    // singleton factory
    class func sharedManager() -> SRWindowManager {
        dispatch_once(&StaticInstance.dispatchToken) {
            StaticInstance.instance = SRWindowManager()
        }
        return StaticInstance.instance!
    }
    
    deinit {
        let nc = NSWorkspace.sharedWorkspace().notificationCenter
        nc.removeObserver(self)
    }
    
    func processes() -> [NSRunningApplication!] {
        let apps = NSWorkspace.sharedWorkspace().runningApplications
        return apps as [NSRunningApplication!]
    }

    func windowProcesses() -> Array<NSRunningApplication?> {
        var apps = Array<NSRunningApplication?>()
        let list = CGWindowListCopyWindowInfo(CGWindowListOption(kCGWindowListExcludeDesktopElements | kCGWindowListOptionOnScreenOnly), CGWindowID(0))
        let windowInfos = list.takeRetainedValue() as Array
        for info in windowInfos as Array<Dictionary<NSString, AnyObject>> {
            let pidPtr: AnyObject? = info[kCGWindowOwnerPID]
            let pidInt = pidPtr as Int
            let pid = CInt(pidInt)
            let app: NSRunningApplication? = NSRunningApplication(processIdentifier: pid)
            if app != nil {
                apps.append(app)
            }
        }
        return apps
    }
    
    func detectWindowChanging(block:((NSRunningApplication!) -> Void)!) {
        let nc = NSWorkspace.sharedWorkspace().notificationCenter
        nc.addObserverForName(NSWorkspaceDidActivateApplicationNotification, object:nil, queue:NSOperationQueue.mainQueue(), usingBlock: {(notification: NSNotification!) -> Void in
            let app = notification!.userInfo![NSWorkspaceApplicationKey] as NSRunningApplication!
            block(app)
        })
    }
}
    
#endif  //#if os(OSX)
