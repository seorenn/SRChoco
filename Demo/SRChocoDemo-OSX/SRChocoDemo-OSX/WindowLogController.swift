//
//  WindowLogController.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa

class WindowLogController: NSObject {
    @IBOutlet var textView: NSTextView!

    override init() {
        super.init()
        
        let wm = SRWindowManager.sharedManager()
        wm.startDetectWindowActivating { (app) -> Void in
            if (app != nil) {
                self.updateAppLog(app)
            }
        }
    }
    
    func log(message: String) {
        let text = message + "\n" + self.textView.string!
        self.textView.string = text
    }
    
    func updateAppLog(app: NSRunningApplication!) {
        let message = "-> \(app.localizedName)"
        self.log(message)
    }
}
