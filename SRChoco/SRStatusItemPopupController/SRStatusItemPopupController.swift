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

class SRStatusItemPopupController: NSObject {
    private let minWidth: CGFloat = 22.0
    
    private var statusItem: NSStatusItem
    private let statusItemButton: NSButton
    private var viewController: NSViewController
    private var popover: NSPopover
    private var event: AnyObject?

    var popoverWillShowHandler: (() -> ())?

    init(viewController: NSViewController, image: NSImage?, alternateImage: NSImage?) {
        self.viewController = viewController
        
        self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)    // FIXME: -1.0 = NSVariableStatusItemLength (bypassing undefined symbol link error)
        
        self.statusItemButton = self.statusItem.valueForKey("_button") as! NSButton
        self.statusItemButton.focusRingType = .None
        self.statusItemButton.setButtonType(.PushOnPushOffButton)
        
        if let icon = image {
            self.statusItem.image = icon
        }
        if let altIcon = alternateImage {
            self.statusItem.alternateImage = altIcon
        }
        
        self.popover = NSPopover()
        self.popover.contentViewController = self.viewController
        self.popover.behavior = NSPopoverBehavior.ApplicationDefined
        
        super.init()
        
        self.statusItem.target = self
        self.statusItem.action = "showPopover"

        self.event = NSEvent.addGlobalMonitorForEventsMatchingMask(.LeftMouseUpMask | .LeftMouseDownMask, handler: {
            event in
            self.hidePopover()
        })
    }
    
    deinit {
        if self.event != nil {
            NSEvent.removeMonitor(self.event!)
            self.event = nil
        }
    }
    
    func showPopover(animated: Bool) {
        if self.popover.shown {
            self.popover.close()
            return
        }
        
        if self.popoverWillShowHandler != nil {
            self.popoverWillShowHandler!()
        }
        
        self.statusItemButton.state = NSOnState
        NSApp.activateIgnoringOtherApps(true)
        
        self.popover.animates = animated
        self.popover.contentSize = self.viewController.view.frame.size
        self.popover.showRelativeToRect(NSZeroRect, ofView: self.statusItemButton, preferredEdge: NSMaxYEdge)
    }
    
    func showPopover() {
        self.showPopover(true)
    }
    
    func hidePopover() {
        if self.popover.shown == false { return }
        
        self.statusItemButton.state = NSOffState
        self.popover.close()
    }
}

#endif
