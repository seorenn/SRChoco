//
// SRUUID.swift
// SRChoco
//
// Created by Seorenn(Heeseung Seo).
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

typealias SRHTTPResponseBlock = (SRHTTPResponse) -> Void

class SRHTTP: NSObject {
    
    // MARK: - Public Properties
    
    var commonHeaders: [String: String] = [:]
    
    // MARK: - Singleton Pattern
    
    struct StaticInstance {
        static var dispatchToken: dispatch_once_t = 0
        static var instance:SRHTTP?
    }
    
    class func defaultHTTP() -> SRHTTP {
        dispatch_once(&StaticInstance.dispatchToken) {
            StaticInstance.instance = SRHTTP(buildCommonHeaders: true)
        }
        return StaticInstance.instance!
    }
    
    // MARK: - Simplipied APIs
    
    class func GET(urlString: String, responseBlock: SRHTTPResponseBlock) {
        // TODO
    }
    
    class func POST(urlString: String, formValues: [String: String]?, responseBlock: SRHTTPResponseBlock) {
        // TODO
    }

    // MARK: - Public APIs
    
    convenience override init() {
        self.init(buildCommonHeaders: false)
    }
    
    init(buildCommonHeaders: Bool) {
        super.init()
        if buildCommonHeaders {
            self.buildCommonHeaders()
        }
    }
    
    func startRequest(request: SRHTTPRequest, responseBlock: SRHTTPResponseBlock) {
        // TODO
    }
    
    // MARK: - Private APIs
    
    func mergeCommonHeaders(targetRequest: SRHTTPRequest) {
        if self.commonHeaders.count <= 0 { return }
        
        for (key, value) in self.commonHeaders {
            if targetRequest.headers[key] == nil {
                targetRequest.headers[key] = value
            }
        }
    }
    
    func buildCommonHeaders() {
        // TODO
    }
}