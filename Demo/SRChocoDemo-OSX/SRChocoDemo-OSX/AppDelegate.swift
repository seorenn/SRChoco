//
//  AppDelegate.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 6/16/14.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet var window: NSWindow


    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        
        // Commented because Xcode 6 Beta2 Compiler Crashing
        //runDemoNSDateExtensions()
        
        let wm = SRWindowManager()
        println("##### Processes:")
        println(wm.windowProcesses())
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

