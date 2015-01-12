//
//  SRInputSourceManager.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 1. 12..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

#import "SRInputSourceManager.h"

@implementation SRInputSourceManager

@synthesize inputSources = _inputSources;

+ (SRInputSourceManager *)sharedManager {
    static SRInputSourceManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SRInputSourceManager alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self refresh];
    }
    return self;
}

- (void)refresh {
    CFArrayRef iss = TISCreateInputSourceList(NULL, NO);
    if (!iss) {
        _inputSources = nil;
        return;
    }
    
    NSMutableArray *sources = [[NSMutableArray alloc] init];
    
    NSInteger issCount = CFArrayGetCount(iss);
    for (int i=0; i < issCount; i++) {
        TISInputSourceRef tis = (TISInputSourceRef)CFArrayGetValueAtIndex(iss, i);
        if (!tis) continue;
        
        SRInputSource *inputSource = [[SRInputSource alloc] initWithTISInputSourceRef:tis];
        if (inputSource.isInputable) {
            [sources addObject:inputSource];
        }
    }
    _inputSources = sources;
}

- (SRInputSource *)inputSourceWithInputSourceID:(NSString *)inputSourceID {
    if (!_inputSources) {
        [self refresh];
    }
    
    for (SRInputSource *inputSource in _inputSources) {
        if ([inputSource.ID isEqualToString:inputSourceID]) {
            return inputSource;
        }
    }
    
    return nil;
}

- (SRInputSource *)currentInputSource {
    TISInputSourceRef tis = TISCopyCurrentKeyboardInputSource();
    if (!tis) return nil;
    
    return [[SRInputSource alloc] initWithTISInputSourceRef:tis];
}

- (NSInteger)currentInputSourceIndex {
    SRInputSource *inputSource = self.currentInputSource;
    if (!_inputSources) [self refresh];
    
    NSInteger i = 0;
    for (SRInputSource *source in _inputSources) {
        if ([source.ID isEqualToString:inputSource.ID]) {
            return i;
        }
        i++;
    }
    
    return -1;
}

@end
