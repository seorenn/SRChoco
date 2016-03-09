//
//  HorizontalSplitViewController.swift
//  SRChocoDemoOSX
//
//  Created by Heeseung Seo on 2016. 3. 9..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

import Cocoa
import SRChoco

class HorizontalSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.setMinimumSize(CGSize(width: 200, height: -1), paneAtIndex: 0)
        self.setMinimumSize(CGSize(width: 300, height: -1), paneAtIndex: 1)
        self.setMinimumSize(CGSize(width: 200, height: -1), paneAtIndex: 2)
        
        self.setMaximumSize(CGSize(width: 1024, height: 1024), paneAtIndex: 0)
        self.setMaximumSize(CGSize(width: 1024, height: 1024), paneAtIndex: 1)
        self.setMaximumSize(CGSize(width: 1024, height: 1024), paneAtIndex: 2)
    }
    
}
