//
//  ViewController.swift
//  SRChocoDemoOSX
//
//  Created by Heeseung Seo on 2015. 8. 3..
//  Copyright © 2015년 Seorenn. All rights reserved.
//

import Cocoa
import SRChocoOSX

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let vc = self.storyboard?.instantiateControllerWithIdentifier("AnotherViewController") as? AnotherViewController {
            self.addChildViewController(vc)
            self.view.addSubview(vc.view, coverSuperview: true)
        }
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

