import Foundation

class SRRegexpGroups: NSObject {
    let text: String
    let results: [NSTextCheckingResult]
    var count: Int {
        return self.results.count
    }
    
    init(results: [NSTextCheckingResult], text: String) {
        self.text = text
        self.results = results
        super.init()
        
        println("SRRegexpGroups initialized with \"\(self.text)\" - \(self.results.count) results")
    }
    
    subscript(index: Int) -> NSTextCheckingResult {
        return self.results[index]
    }
    
    func string(index: Int) -> String {
        let range = self.range(index)
        let result = self.text[range]
        println("\(self.text) #\(index) = \(result)")
        return result
    }
    
    func range(index: Int) -> NSRange {
        let result = self.results[index]
        return result.range
    }
}

class SRRegexp: NSObject {
    private let re: NSRegularExpression?
    
    // MARK: Initializers
    
    init?(_ pattern: String, ignoreCase: Bool = true) {
        var error: NSError?
        var options = NSRegularExpressionOptions(0)
        if ignoreCase { options = .CaseInsensitive }
        
        self.re = NSRegularExpression(pattern: pattern, options: options, error: &error)
        super.init()

        if self.re == nil { return nil }
    }
    
    // MARK: Functions
    
    func find(string: String) -> SRRegexpGroups? {
        let matches = self.re?.matchesInString(string, options: nil, range: NSMakeRange(0, countElements(string)))
        
        if matches?.count > 0 {
            let results = matches! as [NSTextCheckingResult]
            return SRRegexpGroups(results: results, text: string)
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