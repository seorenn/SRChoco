#if os(OSX)
    import Cocoa
    typealias ViewType = NSView
    typealias RectType = NSRect
    typealias PointType = NSPoint
    typealias SizeType = NSSize
#else
    import UIKit
    typealias ViewType = UIView
    typealias RectType = CGRect
    typealias PointType = CGPoint
    typealias SizeType = CGSize
#endif

extension ViewType {
    var x: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    var y: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    var origin: CGPoint {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    var size: CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    var centerPoint: PointType {
        #if os(OSX)
            return NSMakePoint(self.frame.size.width / 2, self.frame.size.height / 2)
        #else
            return CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        #endif
    }
    
    func moveToBelow(view: ViewType, margin: CGFloat = 0) {
        let viewFrame = view.frame
        var myFrame = self.frame
        
        myFrame.origin.y = viewFrame.origin.y + viewFrame.size.height + margin
        self.frame = myFrame
    }
}
