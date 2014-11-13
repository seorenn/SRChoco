import Cocoa

let strlist: Array<AnyObject> = ["a", "b", "c"]

if let v = strlist as? [String] {
    println("strlist is [String]")
}
if let v = strlist as? [Int] {
    println("strlist is [Int]")
}
