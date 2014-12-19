//
//  SRHTTPRequest.swift
//  SRChoco
//
//  Created by Seorenn(Heeseung Seo).
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

import Foundation

enum SRHTTPRequestMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class SRHTTPRequest: NSObject {
    var method: SRHTTPRequestMethod
    var urlString: String
    var headers: [String: String] = [:]
    var formValues: [String: String] = [:]
    var bodyText: String?
    var uploadFileData: NSData?
    
    init(method: SRHTTPRequestMethod, urlString: String) {
        self.method = method
        self.urlString = urlString
        
        super.init()
    }
    
    var url: NSURL? {
        return NSURL(string: self.urlString)
    }
    
    var urlRequest: NSURLRequest? {
        let url = self.url
        if url == nil { return nil }
        let request = NSMutableURLRequest(URL: url!)
        
        if self.headers.count > 0 {
            for (key, value) in self.headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if self.formValues.count > 0 {
            // TODO
        }
        
        // TODO
        return nil
    }
}
