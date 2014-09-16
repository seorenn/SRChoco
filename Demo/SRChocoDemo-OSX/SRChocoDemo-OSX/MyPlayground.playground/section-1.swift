import Cocoa

import Carbon

let currentIS: TISInputSourceRef = TISCopyCurrentKeyboardInputSource().takeUnretainedValue()

let iss = TISCreateInputSourceList(nil, Boolean(0))
let cflist: CFArrayRef = iss.takeUnretainedValue()
let listCount = CFArrayGetCount(cflist)

let firstTISVoidPtr = CFArrayGetValueAtIndex(cflist, 0)
let firstTISCast: TISInputSourceRef = unsafeBitCast(firstTISVoidPtr, TISInputSourceRef.self)
let firstTIS: TISInputSourceRef = UnsafePointer<TISInputSourceRef>(firstTISVoidPtr).memory

firstTISCast === firstTIS

//let categoryVoidPtr = TISGetInputSourceProperty(firstTIS, kTISPropertyInputSourceCategory)
let categoryVoidPtr = TISGetInputSourceProperty(firstTISCast, kTISPropertyInputSourceCategory)
let categoryCF: CFStringRef = unsafeBitCast(categoryVoidPtr, CFStringRef.self)
let category: NSString = categoryCF

//let nameVoidPtr = TISGetInputSourceProperty(firstTIS, kTISPropertyLocalizedName)
let nameVoidPtr = TISGetInputSourceProperty(firstTISCast, kTISPropertyLocalizedName)
let nameCF: CFStringRef = unsafeBitCast(nameVoidPtr, CFStringRef.self)

//let IDVoidPtr = TISGetInputSourceProperty(firstTIS, kTISPropertyInputSourceID)
let IDVoidPtr = TISGetInputSourceProperty(firstTISCast, kTISPropertyInputSourceID)
let IDCF: CFStringRef = unsafeBitCast(IDVoidPtr, CFStringRef.self)

//let bundleIDVoidPtr = TISGetInputSourceProperty(firstTIS, kTISPropertyBundleID)
let bundleIDVoidPtr = TISGetInputSourceProperty(firstTISCast, kTISPropertyBundleID)
let bundleIDCF: CFStringRef = unsafeBitCast(bundleIDVoidPtr, CFStringRef.self)

