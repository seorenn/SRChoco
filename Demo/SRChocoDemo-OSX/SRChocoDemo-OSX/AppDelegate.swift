//
//  AppDelegate.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 6/16/14.
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
        self.statusItemPopupController = SRStatusItemPopupController(viewController: popup, image: image, alternateImage: alternateImage)
        
        let demoFM = DemoSRFileManager()
        demoFM.test()
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

