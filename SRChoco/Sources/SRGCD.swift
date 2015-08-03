//
//  SRGCD.swift
//  SRChoco
//
//  Created by Seorenn on 2015. 8. 3..
//  Copyright © 2015 Seorenn. All rights reserved.
//

import Foundation
import Dispatch

// MARK: - A Simple Class for GCD Multi Tasking

public class SRDispatch {
    public class func mainTask(job: () -> ()) {
        dispatch_async(dispatch_get_main_queue()) {
            job()
        }
    }
    
    public class func backgroundTask(job: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            job()
        }
    }
    
    public class func asyncTask(job: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            job()
        }
    }
    
    private class func timeForDispatch(delay: Double) -> dispatch_time_t {
        let d = delay * Double(NSEC_PER_SEC)
        return dispatch_time(DISPATCH_TIME_NOW, Int64(d))
    }
    
    public class func runAfter(delay: Double, job: () -> ()) {
        dispatch_after(SRDispatch.timeForDispatch(delay), dispatch_get_main_queue()) {
            job()
        }
    }
    
    public class func backgroundRunAfter(delay: Double, job: () -> ()) {
        dispatch_after(SRDispatch.timeForDispatch(delay), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            job()
        }
    }
    
    public class func asyncRunAfter(delay: Double, job: () -> ()) {
        dispatch_after(SRDispatch.timeForDispatch(delay), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            job()
        }
    }
}

// MARK: - A Simple Class for GCD Dispatch Queue

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

// MARK: - A Simple Class of Wrapping Pthreads Mutex

public class SRMutex {
    private var mutex = pthread_mutex_t()
    private var locking: Bool = false
    
    public init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    /**
    Lock mutex
    */
    public func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    /**
    Unlock mutex
    */
    public func unlock() {
        pthread_mutex_unlock(&mutex)
    }
    
    /**
    Run the closure via locking mutex
    */
    public func sync(closure: () -> ()) {
        self.lock()
        closure()
        self.unlock()
    }
}

// MARK: - A Simple Class of Wrapping Semaphore

public class SRSemaphore {
    private let semaphore: dispatch_semaphore_t
    
    public init(value: Int = 0) {
        self.semaphore = dispatch_semaphore_create(value)
    }
    
    public func wait() {
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
    }
    
    public func wait(timeout: NSTimeInterval) {
        let to = dispatch_time_t(UInt64(timeout * NSTimeInterval(NSEC_PER_SEC)))
        dispatch_semaphore_wait(self.semaphore, to)
    }
    
    public func signal() {
        dispatch_semaphore_signal(self.semaphore)
    }
}
