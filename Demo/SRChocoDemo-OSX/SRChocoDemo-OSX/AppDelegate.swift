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

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        let popup = StatusPopupViewController(nibName: "StatusPopupViewController", bundle: nil)
        let image = NSWorkspace.sharedWorkspace().iconForFileType(NSFileTypeForHFSTypeCode(OSType(kGenericFolderIcon)))
        let alternateImage = NSWorkspace.sharedWorkspace().iconForFileType(NSFileTypeForHFSTypeCode(OSType(kGenericApplicationIcon)))
        self.statusItemPopupController = SRStatusItemPopupController(viewController: popup!, image: image, alternateImage: alternateImage)
        
        let demoFM = DemoSRFileManager()
        demoFM.test()
        
        println("Path for HOME: \(SRDirectory.pathForHome)")
        println("Path for Movies: \(SRDirectory.pathForMovies)")
        println("Path for Downloads: \(SRDirectory.pathForDownloads)")
        println("Path for Application Supports: \(SRDirectory.pathForApplicationSupports)")
        println("Path for Caches: \(SRDirectory.pathForCaches)")
        println("Path for Documents: \(SRDirectory.pathForDocuments)")
        println("Path for MainBundle: \(SRDirectory.pathForMainBundle)")
        println("Path for Temporary: \(SRDirectory.pathForTemporary)")

        let key = SRHotKey(keyCode: 49, command: true, control: true, option: true, shift: false)
        SRGlobalHotKeyManager.sharedManager().registerWithHotKey(key) {
            println("Global HotKey Event")
        }
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }

    @IBAction func pressedShowPopup(sender: AnyObject) {
        self.statusItemPopupController?.showPopover()
    }
    @IBAction func pressedHidePopup(sender: AnyObject) {
        self.statusItemPopupController?.hidePopover()
    }

}

