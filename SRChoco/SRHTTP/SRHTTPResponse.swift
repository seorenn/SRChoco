//
//  SRHTTPResponse.swift
//  SRChoco
//
//  Created by Seorenn(Heeseung Seo)
//  Copyright (c) 2014 by Seorenn. All rights reserved.
//

import Foundation

class SRHTTPResponse: NSObject {
    let request: SRHTTPRequest
    var code: Int = 0
    var responseObject: NSURLResponse? = nil {
        didSet {
            let httpResponse: NSHTTPURLResponse = self.responseObject! as NSHTTPURLResponse
            self.code = httpResponse.statusCode
        }
    }
    var error: NSError? = nil
    var receivedData: NSMutableData? = nil
    
    var responseString: String {
        if let data = self.receivedData {
            return NSString(data: data, encoding: NSUTF8StringEncoding)!
        } else {
            return ""
        }
    }
    
    var responseData: NSData? {
        return self.receivedData as NSData?
    }
    
    // MARK: - Public APIs
    
    init(request: SRHTTPRequest) {
        self.request = request
        super.init()
    }
    
    func appendData(data: NSData) {
        if self.receivedData == nil {
            self.receivedData = NSMutableData()
        }
        
        self.receivedData?.appendData(data)
    }
    
    // MARK: - Private APIs
}
