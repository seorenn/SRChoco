import Foundation

public extension String {
    subscript(range: Range<Int>) -> String {
        let start = advance(startIndex, range.startIndex, endIndex)
        let end = advance(startIndex, range.endIndex, endIndex)
        return self[start..<end]
    }
}