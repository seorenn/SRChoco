//
//  ViewController.swift
//  SRChocoDemoiOS
//
//  Created by Heeseung Seo on 2016. 11. 21..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

import UIKit
import SRChoco

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    testURLs()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func testURLs() {
    print("cache: \(URL.urlForCaches)")
    print("documents: \(URL.urlForDocuments)")
    print("tmp: \(URL.urlForTemporary)")
    print("main bundle: \(URL.urlForMainBundle)")
    
    let testTxtURL = URL.applicationContent("test.txt")
    print("content for test.txt: \(testTxtURL)")

    let someGoodTestTxtURL = URL.applicationContent("some/good/test.txt")
    print("content for test.txt: \(someGoodTestTxtURL)")
}


}

