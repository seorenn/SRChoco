import Foundation

extension String {
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
}