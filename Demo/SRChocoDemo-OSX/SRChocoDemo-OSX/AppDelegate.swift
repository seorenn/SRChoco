//
//  AppDelegate.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet var window: NSWindow?

    var statusItemPopupController: SRStatusItemPopupController?

    func applicationDidFinishLaunching(notification: NSNotification) {
        
        Log.debug("[TEST] Start Auto Startup Test =====")
        let appURL = NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath)
        Log.debug("[TEST] App URL: \(appURL?.absoluteString)")

        let autoStart = SRStartupLauncher.sharedLauncher().launchAtStartup
        Log.debug("[TEST] Launch at Login = \(autoStart)")
        Log.debug("[TEST] Set On to Launch at Login")
        SRStartupLauncher.sharedLauncher().launchAtStartup = true
        Log.debug("[TEST] Set Off to Launch at Login")
        SRStartupLauncher.sharedLauncher().launchAtStartup = false
        
        let popup = StatusPopupViewController(nibName: "StatusPopupViewController", bundle: nil)
        let image = NSWorkspace.sharedWorkspace().iconForFileType(NSFileTypeForHFSTypeCode(OSType(kGenericFolderIcon)))
        let alternateImage = NSWorkspace.sharedWorkspace().iconForFileType(NSFileTypeForHFSTypeCode(OSType(kGenericApplicationIcon)))
        self.statusItemPopupController = SRStatusItemPopupController(viewController: popup!, image: image, alternateImage: alternateImage)
        self.statusItemPopupController!.popoverWillShowHandler = {
            () -> () in
            Log.debug("Popover will show!")
        }
        
        let demoFM = DemoSRFileManager()
        demoFM.test()
        
        Log.debug("Path for HOME: \(SRDirectory.pathForHome)")
        Log.debug("Path for Movies: \(SRDirectory.pathForMovies)")
        Log.debug("Path for Downloads: \(SRDirectory.pathForDownloads)")
        Log.debug("Path for Application Supports: \(SRDirectory.pathForApplicationSupports)")
        Log.debug("Path for Caches: \(SRDirectory.pathForCaches)")
        Log.debug("Path for Documents: \(SRDirectory.pathForDocuments)")
        Log.debug("Path for MainBundle: \(SRDirectory.pathForMainBundle)")
        Log.debug("Path for Temporary: \(SRDirectory.pathForTemporary)")

        /*
        Log.debug("All Processes: \(SRWindowManager.sharedManager().processes)")
        for window in SRWindowManager.sharedManager().windows {
            Log.debug("# WindowProcess: \(window)")
        }
        */
        
        Log.debug("##### Testing with SRWindowManager.applicationWindows")
        for window in SRWindowManager.sharedManager().applicationWindows {
            Log.debug("# Application Window: \(window)")
        }

        let key = SRHotKey(keyCode: 49, command: true, control: true, option: true, shift: false)
        SRGlobalHotKeyManager.sharedManager().registerWithHotKey(key) {
            Log.debug("Global HotKey Event")
        }
        
        /*
        SRDispatch.runAfter(1.0) {
            Log.debug("runAfter 1.0")
        }
        SRDispatch.backgroundRunAfter(2.0) {
            Log.debug("backgroundRunAfter 2.0")
        }
        SRDispatch.asyncRunAfter(3.0) {
            Log.debug("asyncRunAfter 3.0")
        }
        */
    }

    func applicationWillTerminate(notification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func pressedShowPopup(sender: AnyObject) {
        self.statusItemPopupController?.showPopover()
    }
    @IBAction func pressedHidePopup(sender: AnyObject) {
        self.statusItemPopupController?.hidePopover()
    }

}

