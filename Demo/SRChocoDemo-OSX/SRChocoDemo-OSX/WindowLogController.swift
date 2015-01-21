//
//  WindowLogController.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa

class WindowLogController: NSObject, SRWindowManagerDelegate {
    @IBOutlet var textView: NSTextView!

    override init() {
        super.init()
        
        let wm = SRWindowManager.sharedManager()
        wm.delegate = self
        wm.startDetect()
    }
    
    func log(message: String) {
        let text = message + "\n" + self.textView.string!
        self.textView.string = text
    }
    
    func updateAppLog(app: NSRunningApplication!) {
        let message = "-> \(app.localizedName)"
        self.log(message)
    }
    
    func windowManager(windowManager: SRWindowManager!, detectWindowActivation runningApplication: NSRunningApplication!) {
        if (runningApplication == nil) { return }
        
        self.updateAppLog(runningApplication)
    }
}
