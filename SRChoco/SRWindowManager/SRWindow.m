//
//  SRWindow.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 12. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

#import "SRWindow.h"

@interface SRWindow () {
    NSRunningApplication *_runningApplication;
}

@end

@implementation SRWindow

@synthesize runningApplication = _runningApplication;

- (id)initWithRunningApplication:(NSRunningApplication *)runningApplication {
    self = [super init];
    if (self) {
        _runningApplication = runningApplication;
    }
    return self;
}

- (id)initWithPID:(pid_t)pid {
    self = [super init];
    if (self) {
        NSRunningApplication *app = [NSRunningApplication runningApplicationWithProcessIdentifier:pid];
        if (!app) return nil;
        
        _runningApplication = app;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<SRWindow: PID[%ld] Name[%@]>", (long)self.pid, self.localizedName];
}

- (NSString *)localizedName {
    if (!_runningApplication) return nil;
    
    return _runningApplication.localizedName;
}

- (pid_t)pid {
    if (!_runningApplication) return 0;
    
    return _runningApplication.processIdentifier;
}

- (NSImage *)icon {
    if (!_runningApplication) return nil;
    
    return _runningApplication.icon;
}

@end
