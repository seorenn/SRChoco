//
// SRUUID.swift
// SRChoco
//
// Created by Seorenn(Heeseung Seo).
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

typealias SRHTTPResponseBlock = (SRHTTPResponse) -> Void

class SRHTTP: NSObject, NSURLConnectionDataDelegate {
    
    private var request: SRHTTPRequest? = nil
    private var response: SRHTTPResponse? = nil
    private var responseBlock: SRHTTPResponseBlock? = nil
    
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
        let request = SRHTTPRequest(method: .GET, urlString: urlString)
        let http = SRHTTP()
        
        http.startRequest(request, responseBlock: responseBlock)
    }
    
    class func POST(urlString: String, formValues: [String: AnyObject]?, responseBlock: SRHTTPResponseBlock) {
        let request = SRHTTPRequest(method: .POST, urlString: urlString)
        if let fv = formValues {
            request.formValues = fv
        }
        let http = SRHTTP()
        
        http.startRequest(request, responseBlock: responseBlock)
    }
    
    // TODO: class func POST with JSON or File
    // TODO: class func PUT
    // TODO: class func DELETE

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

    // TODO: Build method arguments spec.
    func criticalError() {
        // TODO: Generate NSError
    }
    
    func finish(error: NSError?) {
        if self.response == nil {
            self.response = SRHTTPResponse(request: self.request!)
        }
        if error != nil {
            self.response!.error = error
        }
        
        if self.responseBlock != nil {
            self.responseBlock!(self.response!)
        }
        
        self.responseBlock = nil
        self.response = nil
        self.request = nil
    }
    
    func startRequest(request: SRHTTPRequest, responseBlock: SRHTTPResponseBlock) {
        self.request = request
        
        let rq = request.urlRequest
        if rq == nil {
            self.criticalError(); return    // TODO: criticalError paramters
        }
        
        if let connection = NSURLConnection(request: rq!, delegate: self) {
            self.responseBlock = responseBlock
            connection.start()
        }
        else {
            self.criticalError()    // TODO: criticalError parameters
        }
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
    
    // MARK: - NSURLConnectionDataDelegate
    
    func connection(connection: NSURLConnection, willCacheResponse cachedResponse: NSCachedURLResponse) -> NSCachedURLResponse? {
        return cachedResponse
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        self.finish(error)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        if self.response == nil {
            self.response = SRHTTPResponse(request: self.request!)
        }
        self.response?.responseObject = response
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        if self.response == nil { return }
        self.response?.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.finish(nil)
    }
}