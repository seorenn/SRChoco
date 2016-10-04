//
//  SRAuth.swift
//  SRChoco
//
//  Created by Seorenn on 2015. 4. 15.
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

import LocalAuthentication

open class SRAuth {
  
  public static let shared = SRAuth()
  
  open var canAuthWithTouchID: Bool {
    #if os(iOS)
      let context = LAContext()
      var error: NSError?
      let result = context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error)
      
      if error == nil { return result }
      else { return false }
    #else
      return false
    #endif
  }
  
  open func authWithTouchID(reason: String, callback: ((_ auth: Bool) -> Void)?) {
    #if os(iOS)
      let context = LAContext()
      context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply: {
        (result, error) -> Void in
        
        DispatchQueue.main.async {
          callback?(result)
        }
      })
    #endif
  }
}
