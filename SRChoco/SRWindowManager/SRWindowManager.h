//
//  SRWindowManager.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 12. 22..
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

#import "SRApplicationWindow.h"

#if !TARGET_OS_IPHONE

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@class SRWindowManager;

@protocol SRWindowManagerDelegate <NSObject>
@optional
- (void)windowManager:(SRWindowManager *)windowManager detectWindowActivation:(NSRunningApplication *)runningApplication;
@end

@interface SRWindowManager : NSObject

// Returns [SRApplicationWindow] that is created with runningApplications method of NSWorkspace
@property (readonly) NSArray *processes;
// Returns [SRApplicationWindow] that is windows onscreen without desktop elements.
@property (readonly) NSArray *windows;
// TODO: Returns [SRApplicationWindow] that is applications has general window.
@property (readonly) NSArray *applicationWindows;
@property (readonly) BOOL detecting;

@property (weak) id<SRWindowManagerDelegate> delegate;

+ (SRWindowManager *)sharedManager;

- (void)startDetect;
- (void)stopDetect;

@end

#endif