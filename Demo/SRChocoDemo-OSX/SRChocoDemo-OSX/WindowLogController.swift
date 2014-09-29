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
        
        let wm = SRWindowManager()
        wm.detectWindowChanging({ (app:NSRunningApplication!) -> Void in
            if (app != nil) {
                self.updateAppLog(app)
            }
        })

    }
    
    func updateAppLog(app: NSRunningApplication!) {
        let message = "-> \(app.localizedName)"
        let text = message + "\n" + self.textView.string
        
        self.textView.string = text
    }
}
