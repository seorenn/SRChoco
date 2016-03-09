//
//  NSSplitViewControllerExtensions.swift
//  SRChoco
//
//  Created by Heeseung Seo on 2016. 3. 9..
//  Copyright © 2016년 Seorenn. All rights reserved.
//

import Cocoa

public extension NSSplitViewController {
    func setMinimumSize(size: CGSize, paneAtIndex: Int) {
        assert(
            paneAtIndex >= 0 && paneAtIndex < self.splitViewItems.count,
            "paneAtIndex out of range")
        
        let view = self.splitViewItems[paneAtIndex].viewController.view
        
        if size.width >= 0 {
            let constraint = NSLayoutConstraint(
                item: view,
                attribute: .Width,
                relatedBy: .GreaterThanOrEqual,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1.0,
                constant: size.width)
            view.addConstraint(constraint)
        }
        if size.height >= 0 {
            let constraint = NSLayoutConstraint(
                item: view,
                attribute: .Height,
                relatedBy: .GreaterThanOrEqual,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1.0,
                constant: size.height)
            view.addConstraint(constraint)
        }
    }
    
    func setMaximumSize(size: CGSize, paneAtIndex: Int) {
        assert(
            paneAtIndex >= 0 && paneAtIndex < self.splitViewItems.count,
            "paneAtIndex out of range")
        
        let view = self.splitViewItems[paneAtIndex].viewController.view
        
        if size.width >= 0 {
            let constraint = NSLayoutConstraint(
                item: view,
                attribute: .Width,
                relatedBy: .LessThanOrEqual,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1.0,
                constant: size.width)
            view.addConstraint(constraint)
        }
        if size.height >= 0 {
            let constraint = NSLayoutConstraint(
                item: view,
                attribute: .Height,
                relatedBy: .LessThanOrEqual,
                toItem: nil,
                attribute: .NotAnAttribute,
                multiplier: 1.0,
                constant: size.height)
            view.addConstraint(constraint)
        }
    }
}

