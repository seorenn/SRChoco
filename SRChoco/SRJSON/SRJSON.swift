//
//  SRJSON.swift
//  SRChoco
//
//  Created by Seorenn.
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

import Foundation

public class SRJSON {
    private let object: AnyObject?
    
    public var isArray: Bool {
        return self.object is NSArray
    }
    
    public var isDictionary: Bool {
        return self.object is NSDictionary
    }
    
    public var isNull: Bool {
        return self.object is NSNull
    }
    
    public var isValue: Bool {
        return (self.isArray == false && self.isDictionary == false)
    }
    
    public var value: AnyObject? {
        if self.isValue { return self.object }
        return nil
    }
    
    public var intValue: Int? {
        if self.object is Int { return self.object as? Int }
        else if self.object is String {
            let str = self.object as? String
            return str?.toInt()
        }
        return nil
    }
    
    public var stringValue: String? {
        if self.object is String || self.object is NSString {
            return self.object as? String
        }
        return nil
    }
    
    public var floatValue: Float? {
        if self.object is Float || self.object is Double || self.object is Int {
            return self.object as? Float
        }
        return nil
    }
    
    public var count: Int {
        if self.isArray {
            let array = self.object as? [AnyObject]
            return array!.count
        }
        return 0
    }
    
    public class func jsonWithString(string: String) -> SRJSON? {
        let str = string as NSString
        if let data = str.dataUsingEncoding(NSUTF8StringEncoding) {
            return SRJSON(data: data)
        } else {
            return nil
        }
    }
    
    public init?(data: NSData) {
        var error: NSError?
        if let obj: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: &error) {
            self.object = obj
        } else {
            self.object = nil
            return nil
        }
    }
    
    private init(object: AnyObject) {
        self.object = object
    }
    
    public subscript(index: Int) -> SRJSON? {
        if self.isArray == false { return nil }
        let array = self.object as? [AnyObject]
        return SRJSON(object: array![index])
    }
    
    public subscript(key: String) -> SRJSON? {
        if self.isDictionary == false { return nil }
        let dict = self.object as? [String:AnyObject]
        if let object: AnyObject = dict![key] {
            return SRJSON(object: object)
        }
        return nil
    }
}