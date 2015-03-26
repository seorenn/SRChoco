//
//  DemoSRFileManager.swift
//  SRChocoDemo-OSX
//
//  Created by Seorenn.
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

import Cocoa

class DemoSRFileManager {
    func home() -> SRDirectory {
        let fm = SRDirectory(SRDirectory.pathForHome!)
        return fm
    }
    
    init() {
        // TODO
    }
    
    func test() {
        let homeDir = home()
        
        Log.debug("Files in Home Directory -------------------")
        for (name, file) in homeDir.files as [String:SRFile] {
            Log.debug("\(name) \(file)")
        }
        
        Log.debug("Directories in Home Directory ---------------------")
        var desktop: SRDirectory?
        for (name, dir) in homeDir.directories as [String:SRDirectory] {
            if name == "Desktop" {
                desktop = dir
            }
            Log.debug("\(name) \(dir)")
        }
        
        /*
        if desktop != nil {
            Log.debug("Desktop Lazy Loading --------------")
            desktop!.load() {
                Log.debug(desktop)
            }
        }
        */
    }
}
