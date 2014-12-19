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
    
    var code: Int {
        // TODO
        return 404
    }
    
    var responseString: String {
        // TODO
        return ""
    }
    
    var responseData: NSData? {
        // TODO
        return nil
    }
    
    // TODO
    
    init(request: SRHTTPRequest) {
        self.request = request
        super.init()
    }
    
    // TODO
}
