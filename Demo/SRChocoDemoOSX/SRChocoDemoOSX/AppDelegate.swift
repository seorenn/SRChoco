//
//  AppDelegate.swift
//  SRChocoDemoOSX
//
//  Created by Heeseung Seo on 2015. 8. 3..
//  Copyright © 2015년 Seorenn. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

  @IBAction func selectedShowTestViewController(_ sender: Any) {
    let window = NSApplication.shared().mainWindow!
    let vc = TestViewController.instance() as! TestViewController
    window.contentViewController!.presentViewControllerAsModalWindow(vc)
  
  }

}

