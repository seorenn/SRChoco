//
//  DemoSRInputSourceManager.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 7. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

import Cocoa

func runTestSRInputSourceManager() {
    let ism = SRInputSourceManager.sharedManager()
    println("TIS Count = \(ism.tis.count)")
    
    for i in 0..<ism.tis.count {
        let info:SRTISInfo = ism.tis.infoAtIndex(i)
        println("- \(info.name)");
    }
}

class DemoSRInputSourceManager: NSObject {
}
