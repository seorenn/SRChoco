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


    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        
        // Commented because Xcode 6 Beta 1, 2, 3 Compiler Crashing
        runTestNSDateExtensions()
        
        let demoFM = DemoSRFileManager()
        demoFM.test()
        
        let wm = SRWindowManager()
        wm.detectWindowChanging({ (app:NSRunningApplication!) -> Void in
            if app {
                println(app)
            }
        })
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

