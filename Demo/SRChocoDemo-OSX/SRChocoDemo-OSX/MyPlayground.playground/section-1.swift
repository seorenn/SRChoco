import Cocoa



import Carbon
let iss = TISCreateInputSourceList(nil, Boolean(0))
let nsList = iss.takeUnretainedValue().__conversion()
let first = nsList.objectAtIndex(0)
println(first)


let IDPtr = TISGetInputSourceProperty(first, kTISPropertyInputSourceID)
