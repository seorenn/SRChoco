//
//  SRWindowManager.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 12. 22..
//  Copyright (c) 2014 Seorenn. All rights reserved.
//

#import "SRWindowManager.h"

@implementation SRWindowManager

@synthesize detecting = _detecting;

+ (SRWindowManager *)sharedManager {
    static SRWindowManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SRWindowManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSNotificationCenter *nc = [[NSWorkspace sharedWorkspace] notificationCenter];
        [nc addObserver:self
               selector:@selector(didActivateWindowNotification:)
                   name:NSWorkspaceDidActivateApplicationNotification
                 object:nil];
    }
    return self;
}

- (void)dealloc {
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
}

- (void)startDetect {
    _detecting = YES;
}

- (void)stopDetect {
    _detecting = NO;
}

- (void)didActivateWindowNotification:(NSNotification *)notification {
    if (_detecting == NO || self.delegate == nil || [self.delegate respondsToSelector:@selector(windowManager:detectWindowActivation:)] == NO) return;
    
    NSRunningApplication *app = [notification.userInfo objectForKey:NSWorkspaceApplicationKey];
    [self.delegate windowManager:self detectWindowActivation:app];
}

- (__autoreleasing NSArray *)processes {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSArray *apps = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in apps) {
        SRApplicationWindow *window = [[SRApplicationWindow alloc] initWithRunningApplication:app];
        if (!window) continue;
        
        [results addObject:window];
    }
    
    return results;
}

- (__autoreleasing NSArray *)windows {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    CFArrayRef list = CGWindowListCopyWindowInfo(kCGWindowListOptionOnScreenOnly | kCGWindowListExcludeDesktopElements, kCGNullWindowID);
    if (!list) return nil;
    
    NSInteger count = CFArrayGetCount(list);
    for (int i=0; i < count; i++) {
        CFDictionaryRef info = CFArrayGetValueAtIndex(list, i);
        if (!info) continue;
        
        CFNumberRef pidNumber = CFDictionaryGetValue(info, kCGWindowOwnerPID);
        pid_t pid;
        CFNumberGetValue(pidNumber, kCFNumberIntType, &pid);
        
        SRApplicationWindow *window = [[SRApplicationWindow alloc] initWithPID:pid];
        if (!window) continue;
            
        [results addObject:window];
    }
    
    CFRelease(list);
    
    return results;
}

- (__autoreleasing NSArray *)applicationWindows {
    NSMutableArray *results = [[NSMutableArray alloc] init];

    NSArray *apps = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in apps) {
        if (app.activationPolicy != NSApplicationActivationPolicyRegular) continue;
        
        SRApplicationWindow *window = [[SRApplicationWindow alloc] initWithRunningApplication:app];
        [results addObject:window];
    }

    return results;
}

@end
