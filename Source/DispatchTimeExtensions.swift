//
//  DispatchTimeExtensions.swift
//  SRChoco
//
//  Created by Heeseung Seo on 2016. 11. 16..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

import Foundation

// MARK: - from http://www.russbishop.net/quick-easy-dispatchtime
// You can use asyncAfter like this:
//   DispatchQueue.main.asyncAfter(deadline: 5) { ... }

extension DispatchTime: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self = DispatchTime.now() + .seconds(value)
  }
}

extension DispatchTime: ExpressibleByFloatLiteral {
  public init(floatLiteral value: Double) {
    self = DispatchTime.now() + .milliseconds(Int(value * 1000))
  }
}
