//
//  DictionaryExtensions.swift
//  SRChoco
//
//  Created by Seorenn.
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

import Foundation

extension NSDictionary {
    class func dictionaryWithJSON(json: NSData) -> NSDictionary? {
        var error: NSError?
        if let jsonObject: AnyObject = NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.allZeros, error: &error) {
            if jsonObject is NSDictionary { return jsonObject as? NSDictionary }
        }
        return nil
    }
    
    class func dictionaryWithJSONString(json: NSString) -> NSDictionary? {
        if let data = json.dataUsingEncoding(NSUTF8StringEncoding) {
            return NSDictionary.dictionaryWithJSON(data)
        }
        return nil
    }
    
    var JSON: NSData? {
        var error: NSError?
        return NSJSONSerialization.dataWithJSONObject(self, options: NSJSONWritingOptions.PrettyPrinted, error: &error)
    }
    
    var JSONString: NSString? {
        if let data = self.JSON {
            return NSString(data: data, encoding: NSUTF8StringEncoding)
        } else {
            return nil
        }
    }
}