//
//  SRTISBridge.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 7. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

//#if TARGET_OS_MAC

#import "SRTISBridge.h"
#if TARGET_OS_MAC
#import <Carbon/Carbon.h>
#endif

@implementation SRTISInfo

- (id)initWithInputSource:(TISInputSourceRef)inputSource {
    self = [super init];
    if (self) {
#if TARGET_OS_MAC
        CFBooleanRef enabledref = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceIsEnabled);
        BOOL enabled = CFBooleanGetValue(enabledref);
        
        CFStringRef imid = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID);
        
        CFStringRef category = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceCategory);
        NSString *categoryStr = (__bridge NSString *)category;
        NSString *targetCategoryStr = (__bridge NSString *)kTISCategoryKeyboardInputSource;
        
        CFBooleanRef enableCapable = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceIsEnableCapable);
        BOOL c_enable = CFBooleanGetValue(enableCapable);
        
        CFBooleanRef selectCapable = TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceIsSelectCapable);
        BOOL s_enable = CFBooleanGetValue(selectCapable);
        
        CFURLRef urlRef = TISGetInputSourceProperty(inputSource, kTISPropertyIconImageURL);
        
        if (enabled &&
            c_enable &&
            s_enable &&
            [categoryStr isEqualToString:targetCategoryStr])
        {
            _selectable = YES;
        }
        _name = (__bridge NSString *)TISGetInputSourceProperty(inputSource, kTISPropertyLocalizedName);
        _iconURL = (__bridge NSURL *)urlRef;
        _inputSourceID = (__bridge NSString *)imid;
#endif
    }
    
    return self;
}

@end


@interface SRTISBridge () {
    NSArray *inputSources;
}

@end

@implementation SRTISBridge

- (id)init {
    self = [super init];
    if (self) {
        [self makeInputSources];
    }
    return self;
}

- (void)refresh {
    inputSources = nil;
    [self makeInputSources];
}

- (void)makeInputSources {
#if TARGET_OS_MAC
    NSArray *tisList = (__bridge NSArray *)TISCreateInputSourceList(NULL, false);
    inputSources = tisList;
#endif
}

- (NSInteger)count {
#if TARGET_OS_MAC
    return inputSources.count;
#else
    return 0;
#endif
}

- (SRTISInfo *)currentInputSource {
    TISInputSourceRef current = TISCopyCurrentKeyboardInputSource();
    return [[SRTISInfo alloc] initWithInputSource:current];
}

- (SRTISInfo *)infoAtIndex:(NSInteger)index {
#if TARGET_OS_MAC
    TISInputSourceRef inputSource = (__bridge TISInputSourceRef)[inputSources objectAtIndex:index];
    NSAssert(inputSource, @"Out of index or no data");
    return [[SRTISInfo alloc] initWithInputSource:inputSource];
#else
    return nil;
#endif
}

- (void)switchTISAtIndex:(NSInteger)index {
#if TARGET_OS_MAC
    TISInputSourceRef inputSource = (__bridge TISInputSourceRef)[inputSources objectAtIndex:index];
    if (inputSource) {
        TISSelectInputSource(inputSource);
    }
#endif
}


@end

//#endif  // TARGET_OS_MAC
