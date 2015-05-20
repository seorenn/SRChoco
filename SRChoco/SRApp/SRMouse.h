//
//  SRMouse.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 5. 20..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

#import "TargetConditionals.h"

#if !TARGET_OS_IPHONE

#import <Cocoa/Cocoa.h>

@interface SRMouse : NSObject

@property (nonatomic, readonly) NSPoint location;

- (NSPoint)locationOnView:(NSView *)view;
- (NSPoint)locationOnWindow:(NSWindow *)window;

@end

#endif