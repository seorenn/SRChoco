//
//  SRWindowManager.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 12. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "SRWindow.h"

typedef void (^SRWindowManagerActivateBlock)(NSRunningApplication *runningApplication);
@interface SRWindowManager : NSObject

@property (readonly) NSArray *processes;
@property (readonly) NSArray *windows;
@property (readonly) NSArray *applicationWindows;

+ (SRWindowManager *)sharedManager;

- (void)startDetectWindowActivating:(SRWindowManagerActivateBlock)block;

@end
