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
    let code: Int
    let response: NSURLResponse
    
    private var receivedData: NSMutableData? = nil
    
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
    
    init(request: SRHTTPRequest, response: NSURLResponse) {
        self.request = request
        self.response = response
        
        let httpResponse = response as NSHTTPURLResponse
        self.code = httpResponse.statusCode
        super.init()
    }
    
    func appendData(data: NSData) {
        if self.receivedData == nil {
            self.receivedData = NSMutableData()
        }
        
        self.receivedData?.appendData(data)
    }
}
