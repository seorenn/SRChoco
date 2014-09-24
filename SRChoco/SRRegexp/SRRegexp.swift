import Foundation

struct SRRegexp {
    private let re: NSRegularExpression?
    
    // MARK: Initializers
    
    init?(_ pattern: String, ignoreCase: Bool = true) {
        var error: NSError?
        var options = NSRegularExpressionOptions(0)
        if ignoreCase { options = .CaseInsensitive }
        
        self.re = NSRegularExpression(pattern: pattern, options: options, error: &error)
        if self.re == nil { return nil }
    }
    
    // MARK: Functions
    
    func find(string: String) -> [NSTextCheckingResult]? {
        let matches = self.re!.matchesInString(string, options: nil, range: NSMakeRange(0, countElements(string)))
        
        if matches.count > 0 {
            return matches as? [NSTextCheckingResult]
        } else {
            return nil
        }
    }
    
    func test(string: String) -> Bool {
        let matches = self.find(string)
        return (matches != nil && matches?.count > 0)
    }
    
    func replace(string: String, template: String) -> String {
        return re!.stringByReplacingMatchesInString(string, options: nil, range: NSMakeRange(0, countElements(string)), withTemplate: template)
    }
}