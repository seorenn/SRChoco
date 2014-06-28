import Foundation

var dict = Dictionary<String, String>()
dict["a"] = "AAAA"

let fm = NSFileManager.defaultManager()
var error: NSError?
let contents = fm.contentsOfDirectoryAtPath("/Users/hirenn", error: &error)

for content: AnyObject in contents {
    let name: String = content as String
    let fullPath = "/Users/hirenn" + "/" + name
    
    var isDirectory = ObjCBool(0)
    let exists = fm.fileExistsAtPath(fullPath, isDirectory: &isDirectory)
    assert(exists)

    if isDirectory.getLogicValue() {
        println("\(name) is directory")
    } else {
        println("\(name) is file")
    }
}