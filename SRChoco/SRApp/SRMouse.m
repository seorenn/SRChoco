//
//  SRMouse.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 5. 20..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

#import "SRMouse.h"

#if !TARGET_OS_IPHONE

@implementation SRMouse

- (NSPoint)absoluteLocation {
    CGEventRef event = CGEventCreate(NULL);
    NSPoint point = CGEventGetLocation(event);
    CFRelease(event);
    
    return point;
}

- (id)initWithEvent:(NSEvent *)event {
    self = [super init];
    if (self) {
        self.event = event;
    }
    return self;
}

- (NSPoint)locationOnView:(NSView *)view {
    NSAssert(self.event != nil, @"You must assign event property before use this method!");
    return [view convertPoint:[self.event locationInWindow] fromView:nil];
}

@end

#endif
