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
NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, strong, nullable) NSEvent *event;
@property (nonatomic, readonly) NSPoint absoluteLocation;

- (id)initWithEvent:(NSEvent *)event;

- (NSPoint)locationOnView:(NSView *)view;

NS_ASSUME_NONNULL_END
@end

#endif