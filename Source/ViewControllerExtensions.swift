//
//  ViewControllerExtensions.swift
//  SRChoco
//
//  Created by Heeseung Seo on 2016. 11. 2..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

#if os(iOS)
  
  import UIKit

  public extension UIViewController {
    public static func instance(storyboardName: String? = nil, identifier: String? = nil) -> UIViewController {
      if let name = identifier {
        return UIStoryboard(name: storyboardName ?? String(describing: self), bundle: nil).instantiateViewController(withIdentifier: name)
      }
      else {
        return UIStoryboard(name: storyboardName ?? String(describing: self), bundle: nil).instantiateInitialViewController()!
      }
    }
  }
  
#elseif os(macOS) || os(OSX)
  
  import Cocoa
  
  public extension NSViewController {
    public static func instance(storyboardName: String? = nil, identifier: String? = nil) -> NSViewController {
      if let name = identifier {
        return NSStoryboard(name: storyboardName ?? String(describing: self), bundle: nil).instantiateController(withIdentifier: name) as! NSViewController
      }
      else {
        return NSStoryboard(name: storyboardName ?? String(describing: self), bundle: nil).instantiateInitialController() as! NSViewController
      }
    }
  }
  
#endif
