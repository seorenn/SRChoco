//
//  URLExtensions.swift
//  SRChoco
//
//  Created by Heeseung Seo on 2016. 11. 21..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

import Foundation

public extension URL {
  
  // MARK: - URL for macOS system predefined
  
  #if os(macOS)
  
  public static var urlForDownloads: URL {
    return FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
  }
  
  public static var urlForMovies: URL {
    return FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask).first!
  }
  
  public static var urlForDesktop: URL {
    return FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
  }
  
  public static var urlForHome: URL {
    let env = ProcessInfo.processInfo.environment
    return URL(fileURLWithPath: env["HOME"]!)
  }
  
  public static var urlForApplicationSupport: URL {
    let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
    
    guard let executableName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else { return appSupportURL }
    return appSupportURL.appendingPathComponent(executableName, isDirectory: true)
  }
  
  public static var urlForCurrent: URL {
    return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
  }
  
  #endif

  // MARK: - URL for macOS and iOS system predefined

  public static var urlForCaches: URL {
    return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
  }
  
  public static var urlForDocuments: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
  }
  
  public static var urlForTemporary: URL {
    return URL(fileURLWithPath: NSTemporaryDirectory())
  }
  
  public static var urlForMainBundle: URL? {
    return Bundle.main.resourceURL
  }
  
  public static func applicationContent(_ name: String) -> URL {
    #if os(macOS)
      return URL.urlForApplicationSupport.appendingPathComponent(name)
    #elseif os(iOS)
      return URL.urlForDocuments.appendingPathComponent(name)
    #else
      assertionFailure("Cannot generate application content URL for this unknown platform")
      return URL()
    #endif
  }
  
  // MARK: - Common File/Directory Operations
  
  public var isExists: Bool {
    guard isFileURL else { return false }
    return FileManager.default.fileExists(atPath: path)
  }
  
  public var isDirectory: Bool {
    guard isFileURL else { return false }
    
    var isDir: ObjCBool = false
    if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
      return isDir.boolValue
    } else {
      return false
    }
  }
  
  public var isFolder: Bool { return isDirectory }
  
  public var isFile: Bool { return !isDirectory }
  
  public var isRootDirectory: Bool {
    guard isFileURL else { return false }
    return path == "/"
  }
  
}

// MARK: - Utilities

public func mkdir(url: URL, intermediateDirectories: Bool = false) -> Bool {
  guard url.isExists == false else { return false }
  do {
    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: intermediateDirectories, attributes: nil)
    return true
  } catch {
    return false
  }
}

public func + (left: URL, right: String) -> URL {
  return left.appendingPathComponent(right)
}
