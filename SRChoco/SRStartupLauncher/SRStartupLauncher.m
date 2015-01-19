//
//  SRStartupLauncher.m
//  SRChoco
//
//  Created by Seorenn on 2015. 1. 12..
//  Copyright (c) 2015 Seorenn. All rights reserved.
//

#import "SRStartupLauncher.h"

@interface SRStartupLauncher () {
    NSURL *_appURL;
}
@end

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

- (id)init {
    self = [super init];
    if (self) {
        _appURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    }
    return self;
}
- (void)setLaunchAtStartup:(BOOL)launchAtStartup {
    if (self.launchAtStartup == launchAtStartup) return;
    
    if (launchAtStartup) {
        [self addAppToTheLoginItems];
    } else {
        [self removeAppFromTheLoginItems];
    }

    /*
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
     */
}

- (BOOL)launchAtStartup {
    return [self isAppInTheLoginItems];
    /*
    LSSharedFileListItemRef itemRef = [self itemRefInLoginItems];
    BOOL isInList = itemRef != nil;
    if (itemRef != nil) CFRelease(itemRef);
    
    return isInList;
     */
}

/*
- (LSSharedFileListItemRef)itemRefInLoginItems
{
    LSSharedFileListRef loginItemsRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItemsRef == nil) return nil;
    
    CFArrayRef loginItemsSnapshotRef = LSSharedFileListCopySnapshot(loginItemsRef, nil);
    NSArray *loginItems = (__bridge NSArray *)loginItemsSnapshotRef;
    
    for (id itemObj in loginItems) {
        LSSharedFileListItemRef currentItemRef = (__bridge LSSharedFileListItemRef)itemObj;
        CFURLRef urlRef = LSSharedFileListItemCopyResolvedURL(currentItemRef, 0, NULL);
        
        if (urlRef) {
            NSURL *itemURL = (__bridge NSURL *)urlRef;
            
            if ([itemURL isEqualTo:_appURL]) {
                itemURL = nil;
                CFRelease(urlRef);
                //CFRelease(loginItemsSnapshotRef);
                CFRelease(loginItemsRef);
                return currentItemRef;
            }
            
            itemURL = nil;
            CFRelease(urlRef);
        }
    }
    
    CFRelease(loginItemsSnapshotRef);
    CFRelease(loginItemsRef);
    return nil;
}
 */

// Ugly, but no leaks code :-(

- (BOOL)isAppInTheLoginItems {
    BOOL res = NO;
    
    LSSharedFileListRef loginItemsRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItemsRef == nil) return NO;
    
    CFArrayRef loginItemsSnapshotRef = LSSharedFileListCopySnapshot(loginItemsRef, nil);
    NSArray *loginItems = (__bridge NSArray *)loginItemsSnapshotRef;
    
    for (id itemObj in loginItems) {
        LSSharedFileListItemRef currentItemRef = (__bridge LSSharedFileListItemRef)itemObj;
        CFURLRef urlRef = LSSharedFileListItemCopyResolvedURL(currentItemRef, 0, NULL);
        
        if (urlRef) {
            NSURL *itemURL = (__bridge NSURL *)urlRef;
            
            if ([itemURL isEqualTo:_appURL]) {
                res = YES;
                itemURL = nil;
                CFRelease(urlRef);
                //CFRelease(currentItemRef);
                break;
            }
            
            itemURL = nil;
            CFRelease(urlRef);
        }
        
        //CFRelease(currentItemRef);
    }
    
    CFRelease(loginItemsSnapshotRef);
    CFRelease(loginItemsRef);
    
    return res;
}

- (void)addAppToTheLoginItems {
    LSSharedFileListRef loginItemsRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItemsRef == nil) return;
    
    LSSharedFileListItemRef itemRef = LSSharedFileListInsertItemURL(loginItemsRef, kLSSharedFileListItemLast, NULL, NULL, (__bridge CFURLRef)_appURL, NULL, NULL);
    
    if (itemRef) {
        CFRelease(itemRef);
    }
    
    CFRelease(loginItemsRef);
}

- (void)removeAppFromTheLoginItems {
    LSSharedFileListRef loginItemsRef = LSSharedFileListCreate(NULL, kLSSharedFileListSessionLoginItems, NULL);
    if (loginItemsRef == nil) return;
    
    CFArrayRef loginItemsSnapshotRef = LSSharedFileListCopySnapshot(loginItemsRef, nil);
    NSArray *loginItems = (__bridge NSArray *)loginItemsSnapshotRef;
    
    for (id itemObj in loginItems) {
        LSSharedFileListItemRef currentItemRef = (__bridge LSSharedFileListItemRef)itemObj;
        CFURLRef urlRef = LSSharedFileListItemCopyResolvedURL(currentItemRef, 0, NULL);
        
        if (urlRef) {
            NSURL *itemURL = (__bridge NSURL *)urlRef;
            
            if ([itemURL isEqualTo:_appURL]) {
                LSSharedFileListItemRemove(loginItemsRef, currentItemRef);
            }
            
            itemURL = nil;
            CFRelease(urlRef);
        }
        
        //CFRelease(currentItemRef);
    }
    
    CFRelease(loginItemsSnapshotRef);
    CFRelease(loginItemsRef);
}

@end
