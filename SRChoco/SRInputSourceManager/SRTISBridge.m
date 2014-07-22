//
//  SRTISBridge.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 7. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

#import "SRTISBridge.h"
#import <Carbon/Carbon.h>

@implementation SRTISInfo

- (id)initWithInputSource:(TISInputSourceRef)inputSource {
    self = [super init];
    if (self) {
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

- (void)makeInputSources {
    NSArray *tisList = (__bridge NSArray *)TISCreateInputSourceList(NULL, false);
    inputSources = tisList;
}

- (NSInteger)count {
    return inputSources.count;
}

- (SRTISInfo *)infoAtIndex:(NSInteger)index {
    TISInputSourceRef inputSource = (__bridge TISInputSourceRef)[inputSources objectAtIndex:index];
    
    return [[SRTISInfo alloc] initWithInputSource:inputSource];
}


@end
