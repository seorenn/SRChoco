//
// ViewExtensions.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

#if os(OSX)
    import Cocoa
    public typealias ViewType = NSView
    public typealias RectType = NSRect
    public typealias PointType = NSPoint
    public typealias SizeType = NSSize
#else
    import UIKit
    public typealias ViewType = UIView
    public typealias RectType = CGRect
    public typealias PointType = CGPoint
    public typealias SizeType = CGSize
#endif

public extension ViewType {
    public var x: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    public var y: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    public var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    public var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    public var origin: PointType {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    public var size: SizeType {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    public var centerPoint: PointType {
        #if os(OSX)
            return NSMakePoint(self.frame.size.width / 2, self.frame.size.height / 2)
        #else
            return CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        #endif
    }
    
    public func moveToBelow(view: ViewType, margin: CGFloat = 0) {
        let viewFrame = view.frame
        var myFrame = self.frame
        
        myFrame.origin.y = viewFrame.origin.y + viewFrame.size.height + margin
        self.frame = myFrame
    }
}