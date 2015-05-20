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

- (NSPoint)location {
    CGEventRef event = CGEventCreate(NULL);
    NSPoint point = CGEventGetLocation(event);
    CFRelease(event);
    
    return point;
}

+ (NSPoint)locationWithEvent:(NSEvent *)event onView:(NSView *)view {
    return [view convertPoint:[event locationInWindow] fromView:nil];
}

@end

#endif
