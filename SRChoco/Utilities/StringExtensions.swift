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
    
    func containString(string: String, ignoreCase: Bool = false) -> Bool {
        let options = ignoreCase ? NSStringCompareOptions.CaseInsensitiveSearch : NSStringCompareOptions.allZeros
        if let range = self.rangeOfString(string, options: options) {
            return true
        }
        return false
    }
    
    func containStrings(strings: Array<String>, ORMode: Bool = false, ignoreCase: Bool = false) -> Bool {
        for string: String in strings {
            if ORMode && self.containString(string, ignoreCase: ignoreCase) {
                return true
            } else if ORMode == false && self.containString(string, ignoreCase: ignoreCase) == false {
                return false
            }
        }
        
        if ORMode {
            return false
        } else {
            return true
        }
    }
    
    func split(splitter: String? = nil) -> [String] {
        if let s = splitter {
            return self.componentsSeparatedByString(s)
        } else {
            return self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        }
    }

    static func stringWithCFStringVoidPointer(voidPtr: UnsafePointer<Void>) -> String? {
        let cfstr: CFStringRef = unsafeBitCast(voidPtr, CFStringRef.self)
        let nsstr: NSString = cfstr
        return nsstr as String
    }
}