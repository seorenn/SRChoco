//
// SRDispatch.swift
// SRChoco
//
// Created by Seorenn.
// Copyright (c) 2014 Seorenn. All rights reserved.
//


import Foundation

class SRDispatch {
    class func mainTask(job: () -> ()) {
        dispatch_async(dispatch_get_main_queue()) {
            job()
        }
    }
    
    class func backgroundTask(job: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            job()
        }
    }
    
    class func asyncTask(job: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            job()
        }
    }
}