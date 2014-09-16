SRStatusItemPopupController
===========================

The Controller for NSStatusItem with NSPopover components.

NOTE: This module supports OSX platform only.

## How to use

In your AppDelegate:

<pre>
class AppDelegate: NSObject, NSApplicationDelegate {
    // ...
    var statusItemPopupController: SRStatusItemPopupController?

    func applicationdidfinishlaunching(aNotification: NSNotification?) {
        // ...
        let viewController = MyViewController(nibName: "MyViewController", bundle: nil)
        let image = NSImage(name: "Icon")
        let alternateImage = NSImage(name: "Icon-Open")
        self.statusItemPopupController = SRStatusItemPopupController(viewController: viewController, 
                                                                     image: image, 
                                                                     alternateImage: alternateImage)
        // ...
    }
</pre>


