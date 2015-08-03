//
// SRCache.swift
// SRChoco
//
// Created by Seorenn(Heeseung Seo).
// Copyright (c) 2015 Seorenn. All rights reserved.
//

#if os(OSX)
    import Cocoa
    public typealias ImageType = NSImage
#else
    import UIKit
    public typealias ImageType = UIImage
#endif

/**
    Simple Cache Implementation.

    SRCache requires SRGCD(SRDispatchQueue) Module
*/
public class SRCache {
    private let cache: NSCache
    public let name: String
    private let queue: SRDispatchQueue
    private let useDiskCache: Bool
    
    /**
        Initialize with generic memory+disk cache style.
    
        :param: name Name of cache
    */
    public convenience init(name: String) {
        self.init(name: name, memoryCountLimit: 0, useDiskCache: true, cleanDiskCacheWhenInit: false)
    }
    
    /**
        Initialize with memory only cache style.
    
        :param: name Name of cache
        :param: memoryCountLimit Count of limit memory cache (Refer to NSCache's countLimit Property)
    */
    public convenience init(name: String, memoryCountLimit: Int) {
        self.init(name: name, memoryCountLimit: memoryCountLimit, useDiskCache: false, cleanDiskCacheWhenInit: false)
    }
    
    /**
        Common Initializer.
    
        :param: name Name of cache
        :param: memoryCountLimit Count of limit memory cache (Refer to NSCache's countLimit property)
        :param: useDiskCache Set true if you want to use disk cache
        :paran: cleanDiskCacheWhenInit Initializer will clean disk cache if this parameter is true
    */
    public init(name: String, memoryCountLimit: Int, useDiskCache: Bool, cleanDiskCacheWhenInit: Bool) {
        self.name = name
        self.cache = NSCache()
        self.cache.name = name
        self.cache.countLimit = memoryCountLimit
        self.queue = SRDispatchQueue.serialQueue(name)
        self.useDiskCache = useDiskCache
        
        if useDiskCache && cleanDiskCacheWhenInit {
            self.cleanDiskCache()
        }
    }
    
    private func writeDataToDiskCache(key: String, data: NSData) {
        // TODO
    }
    
    private func readDataFromDiskCache(key: String) -> NSData? {
        // TODO
        return nil
    }
    
    public func setImage(key: String, image: ImageType) {
        self.cache.setObject(key, forKey: image)
        
        if self.useDiskCache == false { return }
        
        let data: NSData?
#if os(OSX)
        data = image.TIFFRepresentation
#else
        data = UIImagePNGRepresentation(image)
#endif
        if data != nil {
            self.writeDataToDiskCache(key, data: data!)
        }
    }
    
    public func getImage(key: String) -> ImageType? {
        var image: ImageType? = self.cache.objectForKey(key) as! ImageType?
        
        if image == nil {
            if let data = self.readDataFromDiskCache(key) {
#if os(OSX)
                image = NSImage(data: data)!
#else
                image = UIImage(data: data)!
#endif
            }
        }
        
        return image
    }
    
//    func set(key: String, object: AnyObject, completionHandler: (() -> ())?) {
//        self.queue.async() {
//            self.cache.setObject(object, forKey: key)
//            
//            // TODO: Write to disk
//        }
//        // TODO: Implement
//    }
//    
//    func get(key: String) -> AnyObject? {
//        var object: AnyObject? = self.cache.objectForKey(key)
//        
//        if object == nil {
//            // Find from disk cache
//        }
//        // TODO: Check if object is nil, find this from disk cache...
//        
//        return object
//    }
//    
//    func get(key: String, completionHandler: ((AnyObject?) -> ())?) {
//        self.queue.async() {
//            var object: AnyObject? = self.cache.objectForKey(key)
//
//            if let handler = completionHandler {
//                SRDispatch.mainTask() {
//                    handler(object)
//                }
//            }
//        }
//    }
    
    public func remove(key: String) {
        // TODO
    }
    
    public func clean() {
        // TODO
    }
    
    func cleanDiskCache() {
        // TOOD
    }
}