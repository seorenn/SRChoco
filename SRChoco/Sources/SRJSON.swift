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
    
    public var JSONData: NSData? {
        guard let object = self.object else { return nil }
        return try! NSJSONSerialization.dataWithJSONObject(object, options: .PrettyPrinted)
    }
    
    public var JSONString: String? {
        guard let data = self.JSONData else { return nil }
        return String(data: data, encoding: NSUTF8StringEncoding)
    }
    
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
            return Int(str!)
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
        else if self.isDictionary {
            let dict = self.object as? [String : AnyObject]
            return dict!.count
        }
        return 0
    }
    
    public class func jsonWithString(string: String) -> SRJSON? {
        if let data = string.dataUsingEncoding(NSUTF8StringEncoding) {
            return SRJSON(data: data)
        } else {
            return nil
        }
    }
    
    public init?(data: NSData) {
        do {
            self.object = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
        } catch {
            self.object = nil
            return nil
        }
    }
    
    public convenience init?(JSONString: String) {
        guard let data = JSONString.dataUsingEncoding(NSUTF8StringEncoding) else { return nil }
        self.init(data: data)
    }
    
    private init(object: AnyObject) {
        self.object = object
    }
    
    public subscript(index: Int) -> SRJSON? {
        guard let array = self.object as? [AnyObject] else { return nil }
        return SRJSON(object: array[index])
    }
    
    public subscript(key: String) -> SRJSON? {
        guard let dict = self.object as? [String : AnyObject] else { return nil }
        guard let obj = dict[key] else { return nil }
        return SRJSON(object: obj)
    }
}