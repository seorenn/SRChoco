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
        CFURLRef appURL = (__bridge CFURLRef)[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        LSSharedFileListItemRef itemRef = LSSharedFileListInsertItemURL(loginItemsRef, kLSSharedFileListItemLast, NULL, NULL, appURL, NULL, NULL);
        if (itemRef) {
            CFRelease(itemRef);
        }
    }
    else {
        LSSharedFileListItemRef itemRef = [self itemRefInLoginItems];
        if (itemRef) {
            LSSharedFileListItemRemove(loginItemsRef, itemRef);
            CFRelease(itemRef);
        }
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
    NSURL *appURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    LSSharedFileListRef loginItemsRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItemsRef == nil) return nil;
    
    NSArray *loginItems = (__bridge NSArray *)LSSharedFileListCopySnapshot(loginItemsRef, nil);
    
    for (id itemObj in loginItems) {
        LSSharedFileListItemRef currentItemRef = (__bridge LSSharedFileListItemRef)itemObj;
        CFURLRef urlRef = LSSharedFileListItemCopyResolvedURL(currentItemRef, 0, NULL);
        
        //if (LSSharedFileListItemResolve(currentItemRef, 0, &urlRef, NULL) == noErr) {
        if (urlRef) {
            NSURL *itemURL = (__bridge NSURL *)urlRef;
            
            if ([itemURL.absoluteString isEqualToString:appURL.absoluteString]) {
                CFRelease(loginItemsRef);
                return currentItemRef;
            }
        }
    }
    
    CFRelease(loginItemsRef);
    return nil;
}

@end
