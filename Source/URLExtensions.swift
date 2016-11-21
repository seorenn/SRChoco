//
//  URLExtensions.swift
//  SRChoco
//
//  Created by Heeseung Seo on 2016. 11. 21..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

import Foundation

fileprivate extension String {
  
  fileprivate var firstCharacter: Character {
    return self[startIndex]
  }
  fileprivate var lastCharacter: Character {
    return self[index(before: endIndex)]
  }
  fileprivate var safePathString: String {
    if characters.count <= 0 { return self }
    if lastCharacter == "/" {
      let toIndex = index(before: index(before: endIndex))
      return self[startIndex...toIndex]
    } else {
      return self
    }
  }
  
  fileprivate func stringBackwardBefore(character: Character) -> String {
    if characters.count <= 0 { return self }
    
    var i = index(before: endIndex)
    while i >= startIndex {
      print("index: \(i)")
      if self[i] == character {
        let toIndex = index(after: i)
        return self[toIndex..<endIndex]
      }
      if i > startIndex { i = index(before: i) }
      else { break }
    }
    return ""
  }
  
  fileprivate func stringBackwardRemovedBefore(character: Character) -> String {
    if characters.count <= 0 { return self }
    var i = index(before: endIndex)
    while i >= startIndex {
      if self[i] == character {
        return self[startIndex..<i]
      }
      if i > startIndex { i = index(before: i) }
      else { break }
    }
    return self
  }
  
}

public extension URL {
  
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
  
  // MARK: - Informations
  
  public var name: String {
    return path.stringBackwardBefore(character: "/")
  }
  
  public var nameWithoutExtension: String {
    let n = path.stringBackwardRemovedBefore(character: ".")
    if n.isEmpty { return name }
    return n
  }
  
  public var extensionName: String {
    return name.stringBackwardBefore(character: ".")
  }
}
