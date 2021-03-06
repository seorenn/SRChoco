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
    
    static var urlForDownloads: URL {
        return FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first!
    }
    
    static var urlForMovies: URL {
        return FileManager.default.urls(for: .moviesDirectory, in: .userDomainMask).first!
    }
    
    static var urlForDesktop: URL {
        return FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first!
    }
    
    static var urlForHome: URL {
        let env = ProcessInfo.processInfo.environment
        return URL(fileURLWithPath: env["HOME"]!)
    }
    
    static var urlForApplicationSupport: URL {
        let appSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        
        guard let executableName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else { return appSupportURL }
        return appSupportURL.appendingPathComponent(executableName, isDirectory: true)
    }
    
    static var urlForCurrent: URL {
        return URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    }
    
    #endif
    
    // MARK: - URL for macOS and iOS system predefined
    
    static var urlForCaches: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    static var urlForDocuments: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    static var urlForTemporary: URL {
        return URL(fileURLWithPath: NSTemporaryDirectory())
    }
    
    static var urlForMainBundle: URL? {
        return Bundle.main.resourceURL
    }
    
    static func applicationContent(_ name: String) -> URL {
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
    
    var isExists: Bool {
        guard isFileURL else { return false }
        return FileManager.default.fileExists(atPath: path)
    }
    
    var isDirectory: Bool {
        guard isFileURL else { return false }
        
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            return isDir.boolValue
        } else {
            return false
        }
    }
    
    var isFolder: Bool { return isDirectory }
    
    // determine this is file, not directory. (NOTE: It's different for isFileURL)
    var isFile: Bool { return !isDirectory }
    
    var isRootDirectory: Bool {
        guard isFileURL else { return false }
        return path == "/"
    }
    
    var parentFileURL: URL {
        guard isFileURL else {
            assertionFailure("Cannot generate parent file URL: This is not file URL!")
            return self
        }
        return URL(fileURLWithPath: self.path.stringBackwardRemovedBefore(character: "/"))
    }
    
    // MARK: - Informations
    
    var lastPathComponentWithoutExtension: String {
        let value = lastPathComponent.stringBackwardRemovedBefore(character: ".")
        if value.isEmpty { return lastPathComponent }
        return value
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

public func trash(url: URL) -> Bool {
    do {
        if #available(iOS 11.0, *) {
            try FileManager.default.trashItem(at: url, resultingItemURL: nil)
        } else {
            print("trash api not supported. skip...")
            return false
        }
    } catch {
        return false
    }
    return true
}

public func + (left: URL, right: String) -> URL {
    return left.appendingPathComponent(right)
}

// MARK: -

fileprivate extension String {
    func stringBackwardRemovedBefore(character: Character) -> String {
        if count <= 0 { return self }
        var i = index(before: endIndex)
        while i >= startIndex {
            if self[i] == character {
                return String(self[startIndex..<i])
            }
            if i > startIndex { i = index(before: i) }
            else { break }
        }
        return self
    }
}
