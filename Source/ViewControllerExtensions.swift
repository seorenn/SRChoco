//
//  ViewControllerExtensions.swift
//  SRChoco
//
//  Created by Heeseung Seo on 2016. 11. 2..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

#if os(iOS)
  import UIKit
  public typealias NativeViewControllerType = UIViewController
  public typealias StoryboardType = UIStoryboard
#else
  import Cocoa
  public typealias NativeViewControllerType = NSViewController
  public typealias StoryboardType = NSStoryboard
#endif

public extension NativeViewControllerType {
  
  public static func instance(storyboardName: String? = nil, identifier: String? = nil) -> NativeViewControllerType {
    if let name = identifier {
      return StoryboardType(name: storyboardName ?? String(describing: self), bundle: nil)
        .instantiateController(withIdentifier: name) as! NativeViewControllerType
    }
    else {
      return StoryboardType(name: storyboardName ?? String(describing: self), bundle: nil)
        .instantiateInitialController() as! NativeViewControllerType
    }
  }
  
}
