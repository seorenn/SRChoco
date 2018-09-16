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
open class SRCache {
  fileprivate let cache: NSCache<AnyObject, AnyObject>
  public let name: String
  fileprivate let queue: DispatchQueue
  fileprivate let useDiskCache: Bool
  
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
    self.queue = DispatchQueue(label: "cache")
    self.useDiskCache = useDiskCache
    
    if useDiskCache && cleanDiskCacheWhenInit {
      self.cleanDiskCache()
    }
  }
  
  fileprivate func writeDataToDiskCache(key: String, data: Data) {
    // TODO
  }
  
  fileprivate func readDataFromDiskCache(key: String) -> Data? {
    // TODO
    return nil
  }
  
  open func setImage(key: String, image: ImageType) {
    self.cache.setObject(key as AnyObject, forKey: image)
    
    if self.useDiskCache == false { return }
    
    let data: Data?
    #if os(OSX)
      data = image.tiffRepresentation
    #else
      data = UIImagePNGRepresentation(image)
    #endif
    if data != nil {
      self.writeDataToDiskCache(key: key, data: data!)
    }
  }
  
  open func getImage(key: String) -> ImageType? {
    var image: ImageType? = self.cache.object(forKey: key as AnyObject) as! ImageType?
    
    if image == nil {
      if let data = self.readDataFromDiskCache(key: key) {
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
  
  open func remove(key: String) {
    // TODO
  }
  
  open func clean() {
    // TODO
  }
  
  func cleanDiskCache() {
    // TOOD
  }
}
