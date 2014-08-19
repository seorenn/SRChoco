import Foundation

public struct SRRegexp {
    private let re: NSRegularExpression
    
    // MARK: Initializers
    
    public init(_ pattern: String, ignoreCase: Bool) {
        var error: NSError?
        var options = NSRegularExpressionOptions(0)
        if ignoreCase { options = .CaseInsensitive }
        
        self.re = NSRegularExpression(pattern: pattern, options: options, error: &error)
    }
    
    public init(_ pattern: String) {
        self.init(pattern, ignoreCase: true)
    }
    
    // MARK: Functions
    
    public func find(string: String) -> [NSTextCheckingResult]? {
        let matches = self.re.matchesInString(string, options: nil, range: NSMakeRange(0, countElements(string)))
        
        if matches.count > 0 {
            return matches as? [NSTextCheckingResult]
        } else {
            return nil
        }
    }
    
    public func test(string: String) -> Bool {
        let matches = self.find(string)
        return (matches != nil && matches?.count > 0)
    }
    
    public func replace(string: String, template: String) -> String {
        return re.stringByReplacingMatchesInString(string, options: nil, range: NSMakeRange(0, countElements(string)), withTemplate: template)
    }
}