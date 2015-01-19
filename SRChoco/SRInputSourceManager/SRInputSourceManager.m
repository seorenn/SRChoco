//
//  SRInputSourceManager.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 1. 12..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

#import "SRInputSourceManager.h"

@interface SRInputSourceManager () {
    CFArrayRef _iss;
}
@end

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

- (void)dealloc {
    if (_iss) {
        CFRelease(_iss);
        _iss = nil;
    }
}

- (void)refresh {
    if (_iss) {
        CFRelease(_iss);
        _iss = nil;
    }
    
    _iss = TISCreateInputSourceList(NULL, NO);
    if (!_iss) {
        _inputSources = nil;
        return;
    }
    
    NSMutableArray *sources = [[NSMutableArray alloc] init];
    
    NSInteger issCount = CFArrayGetCount(_iss);
    for (int i=0; i < issCount; i++) {
        TISInputSourceRef tis = (TISInputSourceRef)CFArrayGetValueAtIndex(_iss, i);
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
