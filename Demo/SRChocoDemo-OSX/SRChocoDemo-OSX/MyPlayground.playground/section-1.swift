import Cocoa



//import Carbon
//let iss = TISCreateInputSourceList(nil, Boolean(0))
//let cflist:CFArray = iss.takeUnretainedValue()
//let first = CFArrayGetValueAtIndex(cflist, 0)
//let firstTIS = UnsafePointer<TISInputSource>(first)
//let IDPtr = TISGetInputSourceProperty(TISInputSourceRef(first), kTISPropertyInputSourceID)

//let nsList = iss.takeUnretainedValue().__conversion()
//let first: AnyObject! = nsList.objectAtIndex(0)
//println("first = \(first)")
//let tis: TISInputSource = first as TISInputSource

//let IDPtr = TISGetInputSourceProperty(first, kTISPropertyInputSourceID)

import Swift

let tis = SRTISBridge()
