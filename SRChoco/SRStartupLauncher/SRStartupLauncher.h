//
//  SRStartupLauncher.h
//  SRChoco
//
//  Created by Seorenn on 2015. 1. 12..
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRStartupLauncher : NSObject

@property (nonatomic, assign) BOOL launchAtStartup;

+ (SRStartupLauncher *)sharedLauncher;

@end
