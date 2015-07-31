import Cocoa

let str = "test"
count(str)
//countElement(str)

var arr = [ "a", "b", "c" ]
arr.extend(["d"])
//arr.indexOf("a")





let mstr = NSMutableAttributedString(string: "ABC", attributes: [NSFontAttributeName: NSFont.systemFontOfSize(15),
    NSForegroundColorAttributeName:NSColor.blackColor()])

let elm = NSAttributedString(string: "DEF", attributes: [NSFontAttributeName: NSFont.systemFontOfSize(25),
    NSForegroundColorAttributeName: NSColor.redColor()])

let elm2 = NSAttributedString(string: "GHI", attributes: [NSFontAttributeName: NSFont.systemFontOfSize(9),
    NSForegroundColorAttributeName: NSColor.blueColor(),
    NSBaselineOffsetAttributeName: 8])

mstr.appendAttributedString(elm)
mstr.appendAttributedString(elm2)

mstr.addAttribute(NSBaselineOffsetAttributeName, value: 4, range: NSMakeRange(0, 3))


let field = NSTextField(frame: NSMakeRect(0, 0, 300, 100))
field.attributedStringValue = mstr
