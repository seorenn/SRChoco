//
// SRDispatch.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//


import Foundation

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