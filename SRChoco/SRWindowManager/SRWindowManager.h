//
//  SRWindowManager.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 12. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "SRApplicationWindow.h"

typedef void (^SRWindowManagerActivateBlock)(NSRunningApplication *runningApplication);
@interface SRWindowManager : NSObject

// Returns [SRApplicationWindow] that is created with runningApplications method of NSWorkspace
@property (readonly) NSArray *processes;
// Returns [SRApplicationWindow] that is windows onscreen without desktop elements.
@property (readonly) NSArray *windows;
// TODO: Returns [String(Bundle Identifier):[SRApplicationWindow]] that is applications has general window.
@property (readonly) NSDictionary *applicationWindows;

+ (SRWindowManager *)sharedManager;

- (void)startDetectWindowActivating:(SRWindowManagerActivateBlock)block;

@end
