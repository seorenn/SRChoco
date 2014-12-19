//
// SRStatusItemPopupController.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//

/* NOTE: SRStatusItemPopupController cannot working well without these extensions:
extension NSWindow {
    func canBecomeKeyWindow() -> Bool {
        return true
    }
}
*/

#if os(OSX)

import AppKit

typealias SRStatusItemPopupControllerDrawHandler = (dirtyRect: NSRect, active: Bool) -> ()

class SRStatusItemPopupView: NSView {
    var active = false
    var image: NSImage?
    var alternateImage: NSImage?
    var imageView: NSImageView
    var drawHandler: SRStatusItemPopupControllerDrawHandler?
    var mouseDownHandler: (() -> ())?
    
    var backgroundColor: NSColor?
    var selectedBackgroundColor: NSColor?

    var currentImage: NSImage? {
        if self.active {
            return self.alternateImage ?? self.image
        } else {
            return self.image
        }
    }
    
    override init(frame frameRect: NSRect) {
        self.imageView = NSImageView(frame: frameRect)
        super.init(frame: frameRect)
        self.addSubview(self.imageView)
    }
    
    convenience required init(coder: NSCoder) {
        self.init(frame: NSMakeRect(0, 0, 0, 0))
    }
    
    override var acceptsFirstResponder: Bool { return true }
    
    override func mouseDown(theEvent: NSEvent) {
        self.needsDisplay = true
        if let handler = self.mouseDownHandler {
            handler()
        }
    }
    
    override func rightMouseDown(theEvent: NSEvent) {
        self.mouseDown(theEvent)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        if let drawHandler = self.drawHandler {
            drawHandler(dirtyRect: dirtyRect, active: self.active)
            return
        }
        
        if self.active {
            if let color = self.selectedBackgroundColor {
                color.setFill()
            } else {
                NSColor.clearColor().setFill()
            }
        } else {
            if let color = self.backgroundColor {
                color.setFill()
            } else {
                NSColor.clearColor().setFill()
            }
        }
        
        NSRectFill(dirtyRect)
        if let image = self.currentImage {
            self.imageView.image = image
        }
    }
}

class SRStatusItemPopupController: NSObject {
    private let minWidth: CGFloat = 22.0
    
    private var statusItem: NSStatusItem
    private var statusItemView: SRStatusItemPopupView
    private var viewController: NSViewController
    private var dummyMenu: NSMenu
    private var popover: NSPopover
    private var popoverTouchHandler: AnyObject?
    
    var drawHandler: SRStatusItemPopupControllerDrawHandler? {
        set {
            self.statusItemView.drawHandler = newValue
        }
        get {
            return self.statusItemView.drawHandler
        }
    }
    
    var popoverWillShowHandler: (() -> ())?

    init(viewController: NSViewController, image: NSImage?, alternateImage: NSImage?) {
        self.viewController = viewController
        
        let height = NSStatusBar.systemStatusBar().thickness
        self.statusItemView = SRStatusItemPopupView(frame: NSMakeRect(0, 0, self.minWidth, height))
        self.statusItemView.image = image
        self.statusItemView.alternateImage = alternateImage
        
        self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)    // FIXME: -1.0 = NSVariableStatusItemLength (bypassing undefined symbol link error)
        self.statusItem.view = self.statusItemView
        
        self.dummyMenu = NSMenu()
        
        self.popover = NSPopover()
        self.popover.contentViewController = self.viewController
        
        super.init()
        
        self.statusItemView.mouseDownHandler = {
            if self.popover.shown {
                self.hidePopover()
            } else {
                self.showPopover()
            }
        }
    }
    
    func showPopover(animated: Bool) {
        self.statusItemView.active = true
        self.statusItemView.needsDisplay = true
        
        if self.popover.shown == false {
            if self.popoverWillShowHandler != nil {
                self.popoverWillShowHandler!()
            }
            
            self.popover.animates = animated
            self.popover.contentSize = self.viewController.view.frame.size
            self.statusItem.popUpStatusItemMenu(self.dummyMenu)
            
            self.popover.showRelativeToRect(self.statusItemView.frame, ofView: self.statusItemView, preferredEdge: NSMinYEdge)
            
            let mask: NSEventMask = .LeftMouseDownMask | .RightMouseDownMask  // FIXME: Bypassing Link Error
            self.popoverTouchHandler = NSEvent.addGlobalMonitorForEventsMatchingMask(mask, handler: { (event: NSEvent!) -> Void in
                self.hidePopover()
            })

        }
    }
    
    func showPopover() {
        self.showPopover(true)
    }
    
    func hidePopover() {
        self.statusItemView.active = false
        self.statusItemView.needsDisplay = true
        
        if self.popover.shown {
            self.popover.close()
            
            if self.popoverTouchHandler != nil {
                NSEvent.removeMonitor(self.popoverTouchHandler!)
                self.popoverTouchHandler = nil
            }
        }
    }
}

#endif
