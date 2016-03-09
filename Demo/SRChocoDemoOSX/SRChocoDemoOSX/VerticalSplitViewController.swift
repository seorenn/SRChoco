//
//  VerticalSplitViewController.swift
//  SRChocoDemoOSX
//
//  Created by Heeseung Seo on 2016. 3. 9..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

import Cocoa
import SRChoco

class VerticalSplitViewController: NSSplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        self.setMinimumSize(CGSize(width: 200, height: 100), paneAtIndex: 0)
        self.setMinimumSize(CGSize(width: 200, height: 150), paneAtIndex: 1)
        self.setMinimumSize(CGSize(width: 200, height: 200), paneAtIndex: 2)
        
        self.setMaximumSize(CGSize(width: 500, height: 500), paneAtIndex: 0)
        self.setMaximumSize(CGSize(width: 500, height: 500), paneAtIndex: 1)
        self.setMaximumSize(CGSize(width: 500, height: 500), paneAtIndex: 2)
    }
    
}
