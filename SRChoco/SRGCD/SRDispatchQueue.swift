//
//  SRDispatchQueue.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 3. 23..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

import Cocoa

public class SRDispatchQueue: NSObject {
    let queue: dispatch_queue_t
    
    public class func mainQueue() -> SRDispatchQueue {
        let q = dispatch_get_main_queue()
        return SRDispatchQueue(queue: q)
    }
    
    public class func backgroundQueue() -> SRDispatchQueue {
        let q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        return SRDispatchQueue(queue: q)
    }
    
    public init(queue: dispatch_queue_t) {
        self.queue = queue
        super.init()
    }
    
    public init(identifier: String, serial: Bool) {
        var attr: dispatch_queue_attr_t
        if serial {
            attr = DISPATCH_QUEUE_SERIAL
        } else {
            attr = DISPATCH_QUEUE_CONCURRENT
        }
        
        self.queue = dispatch_queue_create(identifier, attr)
    }
    
    public func sync(job: () -> ()) {
        dispatch_sync(self.queue) {
            job()
        }
    }
    
    public func async(job: () -> ()) {
        dispatch_async(self.queue) {
            job()
        }
    }
}
