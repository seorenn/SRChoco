//
//  SRDispatchQueue.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 3. 23..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

import Dispatch

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
    
    public class func serialQueue(label: String) -> SRDispatchQueue {
        return SRDispatchQueue(label: label, serial: true)
    }
    
    public class func concurrentQueue(label: String) -> SRDispatchQueue {
        return SRDispatchQueue(label: label, serial: false)
    }
    
    private init(queue: dispatch_queue_t) {
        self.queue = queue
        super.init()
    }
    
    private init(label: String, serial: Bool) {
        if serial {
            self.queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL)
        } else {
            self.queue = dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT)
        }
        super.init()
    }
    
    public func sync(job: () -> ()) {
        dispatch_sync(self.queue, job)
    }
    
    public func async(job: () -> ()) {
        dispatch_async(self.queue, job)
    }
    
    public func delay(interval: Double, job: () -> ()) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(interval * Double(NSEC_PER_SEC))), self.queue, job)
    }
}
