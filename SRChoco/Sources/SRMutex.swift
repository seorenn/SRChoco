//
//  SRMutex.swift
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 5. 7.
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

import Foundation

/**
    Simple pthread mutex wrapper class
*/
class SRMutex {
    private var mutex = pthread_mutex_t()
    private var locking: Bool = false
    
    init() {
        pthread_mutex_init(&mutex, nil)
    }
    
    deinit {
        pthread_mutex_destroy(&mutex)
    }
    
    /**
        Lock mutex
    */
    func lock() {
        pthread_mutex_lock(&mutex)
    }
    
    /**
        Unlock mutex
    */
    func unlock() {
        pthread_mutex_unlock(&mutex)
    }
    
    /**
        Run the closure via locking mutex
    */
    func sync(closure: () -> ()) {
        self.lock()
        closure()
        self.unlock()
    }
}