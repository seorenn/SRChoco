//
//  SRStartupLauncher.h
//  SRChoco
//
//  Created by Seorenn on 2015. 1. 12..
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

#if !TARGET_OS_IPHONE

#import <Foundation/Foundation.h>

@interface SRStartupLauncher : NSObject

@property (nonatomic, assign) BOOL launchAtStartup;

+ (SRStartupLauncher *)sharedLauncher;

@end

#endif