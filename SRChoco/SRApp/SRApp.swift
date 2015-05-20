//
// SRApp.swift
// SRChoco
//
// Created by Seorenn(Heeseung Seo).
// Copyright (c) 2015 Seorenn. All rights reserved.
//

#if os(OSX)
import AppKit
#else
import UIKit
#endif

private let g_thisApp = SRApp()

public class SRApp {
    public var thisApp: SRApp {
        return g_thisApp
    }
    
#if os(OSX)
    public let mouse = SRMouse()
#endif
    
}