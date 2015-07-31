//
//  SRSemaphore.swift
//  SRChoco
//
//  Created by Seorenn on 2015. 5. 11.
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

import Foundation

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
