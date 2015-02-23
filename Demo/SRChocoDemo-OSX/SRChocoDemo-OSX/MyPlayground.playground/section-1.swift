import Cocoa

extension NSColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let r = CGFloat((hex & 0xff0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00ff00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000ff) / 255.0
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}

let black = NSColor(hex: 0x000000)
let white = NSColor(hex: 0xffffff)
let red = NSColor(hex:0xff0000)
let green = NSColor(hex: 0x00ff00)
let blue = NSColor(hex: 0x0000ff)
let opGray = NSColor(hex: 0x000000, alpha: 0.5)

