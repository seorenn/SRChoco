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
    println("TIS Count = \(ism.inputSources.count)")
    
    for inputSource: SRInputSource in ism.inputSources {
        println("- \(inputSource.name)");
    }
}

class DemoSRInputSourceManager: NSObject {
}
