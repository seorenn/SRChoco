import Foundation

extension String {
    var length: Int {
        return countElements(self)
    }

    subscript(index: Int) -> Character {
        let elements = Array(self)
        if index >= 0 { return elements[index] }
        else {
            let revIndex = self.length + index
            return elements[revIndex]
        }
    }

    // substring with range
    subscript(range: Range<Int>) -> String {
        let start = advance(startIndex, range.startIndex, endIndex)
        let end = advance(startIndex, range.endIndex, endIndex)
        return self[start..<end]
    }
    
    func trimmedString() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
    func containString(string: String) -> Bool {
        if let range = self.rangeOfString(string) {
            return true
        }
        return false
    }
    
    func containStrings(strings: Array<String>) -> Bool {
        for string: String in strings {
            if self.containString(string) {
                return true
            }
        }
        return false
    }

    static func stringWithCFStringVoidPointer(voidPtr: UnsafePointer<Void>) -> String? {
        let cfstr: CFStringRef = unsafeBitCast(voidPtr, CFStringRef.self)
        let nsstr: NSString = cfstr
        return nsstr as String
    }
}