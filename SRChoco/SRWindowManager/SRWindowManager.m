//
//  SRWindowManager.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 12. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

#import "SRWindowManager.h"

@interface SRWindowManager() {
    SRWindowManagerActivateBlock _activateBlock;
}
@end

@implementation SRWindowManager

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
    _activateBlock = nil;
    [[[NSWorkspace sharedWorkspace] notificationCenter] removeObserver:self];
}

- (void)startDetectWindowActivating:(SRWindowManagerActivateBlock)block {
    _activateBlock = block;
}

- (void)didActivateWindowNotification:(NSNotification *)notification {
    if (!_activateBlock) return;
    
    NSRunningApplication *app = [notification.userInfo objectForKey:NSWorkspaceApplicationKey];
    _activateBlock(app);
}

- (NSArray *)processes {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSArray *apps = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in apps) {
        SRApplicationWindow *window = [[SRApplicationWindow alloc] initWithRunningApplication:app];
        if (!window) continue;
        
        [results addObject:window];
    }
    
    return results;
}

- (NSArray *)windows {
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
    
    return results;
}

- (NSDictionary *)applicationWindows {
    /*
     References: http://stackoverflow.com/questions/17010638/osx-objective-c-window-management-manipulate-the-frames-visibility-of-other
     This will requires User Permission from Preferences
     
     for (NSRunningApplication *runningApplication in [[NSWorkspace sharedWorkspace] runningApplications)] {
     AXUIElementRef applicationRef = AXUIElementCreateApplication([runningApplication processIdentifier]);
     CFArrayRef applicationWindows;
     AXUIElementCopyAttributeValues(applicationRef, kAXWindowsAttribute, 0, 100, &applicationWindows);
     
     if (!applicationWindows) continue;
     
     for (CFIndex i = 0; i < CFArrayGetCount(applicationWindows); ++i) {
     AXUIElementRef windowRef = CFArrayGetValueAtIndex(applicationWindows, i);
     CGPoint upperLeft = { .x = 0, .y = 0 };
     AXValueRef positionRef = AXValueCreate(kAXValueCGPointType, &upperLeft);
     AXUIElementSetAttributeValue(windowRef, kAXPositionAttribute, positionRef);
     }
     }
     */
    NSMutableDictionary *results = [[NSMutableDictionary alloc] init];

    NSArray *apps = [[NSWorkspace sharedWorkspace] runningApplications];
    for (NSRunningApplication *app in apps) {
        if (app.activationPolicy != NSApplicationActivationPolicyRegular) continue;
        
        if ([results objectForKey:app.bundleIdentifier] != nil) {
            NSLog(@"Skip already bundled application: %@", app);
            continue;
        }
        SRApplicationWindow *window = [[SRApplicationWindow alloc] initWithRunningApplication:app];
        [results setObject:window forKey:app.bundleIdentifier];
    }

    return results;
}

@end
