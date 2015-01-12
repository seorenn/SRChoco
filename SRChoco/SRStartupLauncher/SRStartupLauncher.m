//
//  SRStartupLauncher.m
//  SRChoco
//
//  Created by Seorenn on 2015. 1. 12..
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

#import "SRStartupLauncher.h"

@implementation SRStartupLauncher

@synthesize launchAtStartup = _launchAtStartup;

+ (SRStartupLauncher *)sharedLauncher {
    static SRStartupLauncher *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SRStartupLauncher alloc] init];
    });
    return instance;
}

- (void)setLaunchAtStartup:(BOOL)launchAtStartup {
    if (self.launchAtStartup == launchAtStartup) return;
    
    LSSharedFileListRef loginItemsRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItemsRef == nil) return;
    
    if (launchAtStartup) {
        CFURLRef appUrl = (__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        LSSharedFileListItemRef itemRef = LSSharedFileListInsertItemURL(loginItemsRef, kLSSharedFileListItemLast, NULL, NULL, appUrl, NULL, NULL);
        if (itemRef) CFRelease(itemRef);
    }
    else {
        LSSharedFileListItemRef itemRef = [self itemRefInLoginItems];
        LSSharedFileListItemRemove(loginItemsRef,itemRef);
        if (itemRef != nil) CFRelease(itemRef);
    }
    
    CFRelease(loginItemsRef);
}

- (BOOL)launchAtStartup {
    LSSharedFileListItemRef itemRef = [self itemRefInLoginItems];
    BOOL isInList = itemRef != nil;
    if (itemRef != nil) CFRelease(itemRef);
    
    return isInList;
}

- (LSSharedFileListItemRef)itemRefInLoginItems
{
    LSSharedFileListItemRef itemRef = nil;
    
    NSURL *appUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    LSSharedFileListRef loginItemsRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItemsRef == nil) return nil;
    
    NSArray *loginItems = (__bridge NSArray *)LSSharedFileListCopySnapshot(loginItemsRef, nil);
    
    for (int currentIndex = 0; currentIndex < [loginItems count]; currentIndex++) {
        CFURLRef urlRef = NULL;
        
        LSSharedFileListItemRef currentItemRef = (__bridge LSSharedFileListItemRef)[loginItems objectAtIndex:currentIndex];
        if (LSSharedFileListItemResolve(currentItemRef, 0, &urlRef, NULL) == noErr) {
            NSURL *itemURL = (__bridge NSURL *)urlRef;
            
            if ([itemURL isEqual:appUrl]) {
                itemRef = currentItemRef;
            }
        }
    }
    
    if (itemRef != nil) CFRetain(itemRef);
    
    CFRelease(loginItemsRef);
    
    return itemRef;
}

@end
