//
//  ViewController.swift
//  SRChocoDemoOSX
//
//  Created by Heeseung Seo on 2015. 8. 3..
//  Copyright © 2015년 Seorenn. All rights reserved.
//

import Cocoa
import SRChoco

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let vc = self.storyboard?.instantiateController(withIdentifier: "AnotherViewController") as? AnotherViewController {
            self.addChild(vc)
            self.view.addSubview(vc.view, coverSuperview: true)
        }
    }



}

