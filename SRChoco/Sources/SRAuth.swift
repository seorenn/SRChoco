//
//  SRAuth.swift
//  SRChoco
//
//  Created by Seorenn on 2015. 4. 15.
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

import LocalAuthentication

public class SRAuth {
    public var canAuthWithTouchID: Bool {
#if os(iOS)
        let context = LAContext()
        var error: NSError?
        let result = context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &error)
        
        if error == nil { return result }
        else { return false }
#else
        return false
#endif
    }
    
    public func authWithTouchID(reason: String, callback: ((auth: Bool) -> Void)?) {
#if os(iOS)
        let context = LAContext()
        context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
            (result: Bool, error: NSError!) in
            dispatch_async(dispatch_get_main_queue()) {
                return result
            }
        }
#endif
    }
}