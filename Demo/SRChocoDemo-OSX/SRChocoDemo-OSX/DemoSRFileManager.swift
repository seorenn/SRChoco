//
//  DemoSRFileManager.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 7. 12..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

import Cocoa

class DemoSRFileManager {
    func home() -> SRDirectory {
        let fm = SRDirectory(SRDirectory.pathForHome())
        return fm
    }
    
    init() {
        // TODO
    }
    
    func test() {
        let homeDir = home()
        homeDir.load()
        
        println("Files in Home Directory -------------------")
        for (name, file) in homeDir.files as [String:SRFile] {
            println("\(name) \(file)")
        }
        
        println("Directories in Home Directory ---------------------")
        var desktop: SRDirectory?
        for (name, dir) in homeDir.directories as [String:SRDirectory] {
            if name == "Desktop" {
                desktop = dir
            }
            println("\(name) \(dir)")
        }
        
        if desktop {
            println("Desktop Lazy Loading --------------")
            desktop?.load() {
                println(desktop)
            }
        }
    }
}
