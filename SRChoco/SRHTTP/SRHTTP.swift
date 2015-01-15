//
// SRUUID.swift
// SRChoco
//
// Created by Seorenn(Heeseung Seo).
// Copyright (c) 2014 Seorenn. All rights reserved.
//

import Foundation

private let _httpSharedInstance = SRHTTP(buildCommonHeaders: true)

typealias SRHTTPResponseBlock = (SRHTTPResponse) -> Void
typealias SRHTTPErrorBlock = (NSError) -> Void

class SRHTTP: NSObject, NSURLConnectionDataDelegate {
    
    private var request: SRHTTPRequest? = nil
    private var response: SRHTTPResponse? = nil
    private var responseBlock: SRHTTPResponseBlock? = nil
    private var errorBlock: SRHTTPErrorBlock? = nil
    
    var commonHeaders: [String: String] = [:]
    
    class func defaultHTTP() -> SRHTTP {
        return _httpSharedInstance
    }
    
    // MARK: - Simplipied APIs
    
    class func GET(urlString: String, responseBlock: SRHTTPResponseBlock, errorBlock: SRHTTPErrorBlock) {
        let request = SRHTTPRequest(method: .GET, urlString: urlString)
        let http = SRHTTP()
        
        http.startRequest(request, onResponse: responseBlock, onError: errorBlock)
    }
    
    class func POST(urlString: String, formValues: [String: AnyObject]?, responseBlock: SRHTTPResponseBlock, errorBlock: SRHTTPErrorBlock) {
        let request = SRHTTPRequest(method: .POST, urlString: urlString)
        if let fv = formValues {
            request.formValues = fv
        }
        let http = SRHTTP()
        
        http.startRequest(request, onResponse: responseBlock, onError: errorBlock)
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

    private func buildError(message: String) -> NSError {
        let userInfo: [String:String] = [ NSLocalizedDescriptionKey: message ]
        let error = NSError(domain: "SRHTTP", code: 0, userInfo: userInfo)
        
        return error
    }
    
    private func clear() {
        self.responseBlock = nil
        self.errorBlock = nil
        self.response = nil
        self.request = nil
    }
    
    private func onError(error: NSError) {
        if self.errorBlock != nil {
            self.errorBlock!(error)
        }
        
        self.clear()
    }
    
    private func finish() {
        if self.responseBlock != nil {
            self.responseBlock!(self.response!)
        }
        
        self.clear()
    }
    
    func startRequest(request: SRHTTPRequest, onResponse: SRHTTPResponseBlock, onError: SRHTTPErrorBlock) {
        self.request = request
        
        let rq = request.urlRequest
        if rq == nil {
            let error = self.buildError("Failed to Generate NSURLRequest Object")
            self.onError(error); return
        }
        
        if let connection = NSURLConnection(request: rq!, delegate: self) {
            self.responseBlock = onResponse
            self.errorBlock = onError
            connection.start()
        }
        else {
            let error = self.buildError("Failed to Generate NSURLConnection Object")
            self.onError(error)
        }
    }
    
    private func mergeCommonHeaders(targetRequest: SRHTTPRequest) {
        if self.commonHeaders.count <= 0 { return }
        
        for (key, value) in self.commonHeaders {
            if targetRequest.headers[key] == nil {
                targetRequest.headers[key] = value
            }
        }
    }
    
    private func buildCommonHeaders() {
        // TODO
    }
    
    // MARK: - NSURLConnectionDataDelegate
    
    func connection(connection: NSURLConnection, willCacheResponse cachedResponse: NSCachedURLResponse) -> NSCachedURLResponse? {
        return cachedResponse
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        self.onError(error)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        self.response = SRHTTPResponse(request: self.request!, response: response)
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        if self.response == nil { return }
        self.response?.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        self.finish()
    }
}