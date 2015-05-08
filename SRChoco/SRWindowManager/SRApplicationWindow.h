//
//  SRApplicationWindow.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 12. 22..
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

#import "TargetConditionals.h"

#if !TARGET_OS_IPHONE

#import <Cocoa/Cocoa.h>

@interface SRApplicationWindow : NSObject

- (id)initWithRunningApplication:(NSRunningApplication *)runningApplication;
- (id)initWithPID:(pid_t)pid;

@property (readonly) NSRunningApplication *runningApplication;
@property (readonly) NSString *bundleIdentifier;
@property (readonly) NSString *localizedName;
@property (readonly) pid_t pid;
@property (readonly) NSImage *icon;

@end

#endif