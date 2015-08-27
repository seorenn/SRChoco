//
//  SRGCD.swift
//  Classes wrapping features of Apple GCD(Grand Central Dispatch)
//  SRChoco
//
//  Created by Seorenn on 2015. 8. 3..
//  Copyright © 2015 Seorenn. All rights reserved.
//

import Foundation
import Dispatch

private func dispatchTime(delay: Double) -> dispatch_time_t {
    let d = delay * Double(NSEC_PER_SEC)
    return dispatch_time(DISPATCH_TIME_NOW, Int64(d))
}

private func backgroundQueue() -> dispatch_queue_t {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
}

// MARK: - Simple Dispatch Functions

public func backgroundTask(task: () -> ()) {
    dispatch_async(backgroundQueue()) {
        task()
    }
}

public func mainTask(task: () -> ()) {
    dispatch_async(dispatch_get_main_queue()) {
        task()
    }
}

public func runAfter(delay: Double, task: () -> ()) {
    dispatch_after(dispatchTime(delay), dispatch_get_main_queue()) {
        task()
    }
}

public func backgroundRunAfter(delay: Double, task: () -> ()) {
    dispatch_after(dispatchTime(delay), backgroundQueue()) {
        task()
    }
}

// MARK: - A Simple Class for GCD Dispatch Queue

public class SRDispatchQueue {
    private let queue: dispatch_queue_t
    
    public class func mainQueue() -> SRDispatchQueue {
        let q = dispatch_get_main_queue()
        return SRDispatchQueue(queue: q)
    }
    
    public class func globalQueue(priority: Int = DISPATCH_QUEUE_PRIORITY_DEFAULT) -> SRDispatchQueue {
        let q = dispatch_get_global_queue(priority, 0)
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
    }
    
    private init(label: String, serial: Bool) {
        if serial {
            self.queue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL)
        } else {
            self.queue = dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT)
        }
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

// MARK: - A Simple Class for GCD Dispatch Group

public class SRDispatchGroup {
    private let group = dispatch_group_create()
    
    public init() {}
    
    public func async(queue: SRDispatchQueue, task: () -> ()) {
        dispatch_group_async(self.group, queue.queue, task)
    }
    
    public func async(task: () -> ()) {
        dispatch_group_async(self.group, backgroundQueue(), task)
    }
    
    public func notify(queue: SRDispatchQueue, task: () -> ()) {
        dispatch_group_notify(self.group, queue.queue, task)
    }
    
    public func notify(task: () -> ()) {
        dispatch_group_notify(self.group, backgroundQueue(), task)
    }
    
    public func wait(timeout: dispatch_time_t = DISPATCH_TIME_FOREVER) {
        dispatch_group_wait(self.group, timeout)
    }
    
    public func wait(timeout: Double = 0) {
        let time: dispatch_time_t
        if timeout <= 0 {
            time = DISPATCH_TIME_FOREVER
        } else {
            time = dispatchTime(timeout)
        }
        dispatch_group_wait(self.group, time)
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
    
    public func lock() {
        pthread_mutex_lock(&mutex)
    }
    
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
