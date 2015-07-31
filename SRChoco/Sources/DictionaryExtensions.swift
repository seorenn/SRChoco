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
        do {
            let jsonObject = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions())
            return jsonObject as? NSDictionary
        } catch {
            return nil
        }
    }
    
    class func dictionaryWithJSONString(json: NSString) -> NSDictionary? {
        if let data = json.dataUsingEncoding(NSUTF8StringEncoding) {
            return NSDictionary.dictionaryWithJSON(data)
        }
        return nil
    }
    
    var JSON: NSData? {
        do {
            return try NSJSONSerialization.dataWithJSONObject(self, options: .PrettyPrinted)
        } catch {
            return nil
        }
    }
    
    var JSONString: NSString? {
        if let data = self.JSON {
            return NSString(data: data, encoding: NSUTF8StringEncoding)
        } else {
            return nil
        }
    }
}