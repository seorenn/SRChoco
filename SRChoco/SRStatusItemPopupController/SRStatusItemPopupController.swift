#if os(OSX)

import AppKit

typealias SRStatusItemPopupControllerDrawHandler = (dirtyRect: NSRect, active: Bool) -> ()

class SRStatusItemPopupView: NSView {
    var active = false
    var image: NSImage?
    var alternateImage: NSImage?
    var imageView: NSImageView?
    var drawHandler: SRStatusItemPopupControllerDrawHandler?
    var mouseDownHandler: (() -> ())?
    
    var currentImage: NSImage? {
        if self.active {
            return self.alternateImage ?? self.image
        } else {
            return self.image
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.imageView = NSImageView(frame: frameRect)
        self.addSubview(self.imageView!)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func mouseDown(theEvent: NSEvent!) {
        self.needsDisplay = true
        if let handler = self.mouseDownHandler {
            handler()
        }
    }
    
    override func rightMouseDown(theEvent: NSEvent!) {
        self.mouseDown(theEvent)
    }
    
    override func drawRect(dirtyRect: NSRect) {
        if let drawHandler = self.drawHandler {
            drawHandler(dirtyRect: dirtyRect, active: self.active)
            return
        }
        
        if self.active {
            NSColor.selectedMenuItemColor().setFill()
        } else {
            NSColor.clearColor().setFill()
        }
        
        NSRectFill(dirtyRect)
        if let image = self.currentImage {
            self.imageView!.image = image
        }
    }
}

class SRStatusItemPopupController: NSObject {
    private let minWidth: CGFloat = 22.0
    
    private var statusItem: NSStatusItem?
    private var statusItemView: SRStatusItemPopupView?
    private var viewController: NSViewController?
    private var dummyMenu: NSMenu?
    private var popover: NSPopover?
    private var popoverTransiencyMonitor: AnyObject?
    
    var drawHandler: SRStatusItemPopupControllerDrawHandler? {
        set {
            self.statusItemView!.drawHandler = newValue
        }
        get {
            return self.statusItemView!.drawHandler
        }
    }
    
    init(viewController: NSViewController, image: NSImage?, alternateImage: NSImage?) {
        super.init()
        self.viewController = viewController
        
        let height = NSStatusBar.systemStatusBar().thickness
        self.statusItemView = SRStatusItemPopupView(frame: NSMakeRect(0, 0, self.minWidth, height))
        self.statusItemView?.image = image
        self.statusItemView?.alternateImage = alternateImage
        self.statusItemView?.mouseDownHandler = {
            if let popover = self.popover {
                if popover.shown {
                    self.hidePopover()
                } else {
                    self.showPopover()
                }
            } else {
                self.showPopover()
            }
        }
        
        self.statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)    // FIXME: -1.0 = NSVariableStatusItemLength (bypassing undefined symbol link error)
        self.statusItem!.view = self.statusItemView
        
        self.dummyMenu = NSMenu()
    }
    
    func showPopover(animated: Bool) {
        self.statusItemView!.active = true
        self.statusItemView!.needsDisplay = true
        
        if self.popover == nil {
            self.popover = NSPopover()
            self.popover!.contentViewController = self.viewController
        }
        
        if self.popover!.shown == false {
            self.popover!.animates = animated
            self.statusItem!.popUpStatusItemMenu(self.dummyMenu)
            
            let edge = NSRectEdge(CGRectEdge.MinYEdge.toRaw())  // FIXME: MinYEdge is CGRectEdge in currently; Yeah Build Error! :-(
            self.popover!.showRelativeToRect(self.statusItemView!.frame, ofView: self.statusItemView!, preferredEdge: edge)
            
            let mask: NSEventMask = NSEventMask.LeftMouseDownMask | NSEventMask.RightMouseDownMask  // FIXME: Bypassing Link Error
            self.popoverTransiencyMonitor = NSEvent.addGlobalMonitorForEventsMatchingMask(mask, handler: { (event: NSEvent!) -> Void in
                self.hidePopover()
            })

        }
    }
    
    func showPopover() {
        self.showPopover(true)
    }
    
    func hidePopover() {
        self.statusItemView!.active = false
        self.statusItemView!.needsDisplay = true
        
        if self.popover != nil && self.popover!.shown {
            self.popover!.close()
            
            if self.popoverTransiencyMonitor != nil {
                NSEvent.removeMonitor(self.popoverTransiencyMonitor)
                self.popoverTransiencyMonitor = nil
            }
        }
    }
}

#endif
