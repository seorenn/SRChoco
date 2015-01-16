//
//  SRInputSource.m
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 1. 12..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

#import "SRInputSource.h"
#import <Cocoa/Cocoa.h>

@interface SRInputSource() {
    TISInputSourceRef _tis;
    CFBooleanRef _isSelectCapableRef;
    BOOL _triedIconLoad;
}
@property (nonatomic, readonly) NSURL *iconImageTIFFURL;
@end

@implementation SRInputSource

@synthesize localizedName = _localizedName;
@synthesize ID = _ID;
@synthesize type = _type;
@synthesize isSelectCapable = _isSelectCapable;
@synthesize iconImageURL = _iconImageURL;
@synthesize iconImageTIFFURL = _iconImageTIFFURL;
@synthesize iconImage = _iconImage;

- (id)initWithTISInputSourceRef:(TISInputSourceRef)tis {
    self = [super init];
    if (self) {
        _tis = tis;
    }
    return self;
}

- (void)activate {
    if (!_tis) return;
    
    TISSelectInputSource(_tis);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<SRInputSource: %@(%@)>", self.localizedName, self.ID];
}

#pragma mark - Properties

- (NSString *)localizedName {
    if (!_localizedName) {
        _localizedName = (__bridge NSString *)TISGetInputSourceProperty(_tis, kTISPropertyLocalizedName);
    }
    return _localizedName;
}

- (NSString *)ID {
    if (!_ID) {
        _ID = (__bridge NSString *)TISGetInputSourceProperty(_tis, kTISPropertyInputSourceID);
    }
    return _ID;
}

- (NSString *)type {
    if (!_type) {
        _type = (__bridge NSString *)TISGetInputSourceProperty(_tis, kTISPropertyInputSourceType);
    }
    return _type;
}

- (BOOL)isSelectCapable {
    if (!_isSelectCapableRef) {
        _isSelectCapableRef = (CFBooleanRef)TISGetInputSourceProperty(_tis, kTISPropertyInputSourceIsSelectCapable);
        _isSelectCapable = CFBooleanGetValue(_isSelectCapableRef);
    }
    
    return _isSelectCapable;
}

- (NSURL *)iconImageURL {
    if (!_iconImageURL) {
        _iconImageURL = (__bridge NSURL *)TISGetInputSourceProperty(_tis, kTISPropertyIconImageURL);
    }
    return _iconImageURL;
}

- (NSImage *)iconImage {
    if (_triedIconLoad) { return _iconImage; }
    
    if (_iconImage == nil) {
        IconRef iconRef = TISGetInputSourceProperty(_tis, kTISPropertyIconRef);
        if (iconRef) {
            _iconImage = [[NSImage alloc] initWithIconRef:iconRef];
        }
        
        NSImage *icon1 = [[NSImage alloc] initWithContentsOfURL:self.iconImageURL];
        if (icon1) {
            _iconImage = icon1;
        }
        
        if (self.iconImageTIFFURL) {
            NSImage *icon2 = [[NSImage alloc] initWithContentsOfURL:self.iconImageTIFFURL];
            if (icon2) {
                _iconImage = icon2;
            }
        }
    }
    
    _triedIconLoad = YES;
    
    return _iconImage;
}

// NOTE: This is alternates of iconImageURL.
// Some Input Source has invalid icon extension name (aka. png)
// But existing file's extension name was 'tiff'
// This getter will returns similar path with another extension name '.tiff'
- (NSURL *)iconImageTIFFURL {
    if ([[self.iconImageURL.path pathExtension] isEqualToString:@"png"]) {
        NSString *originalPath = [self.iconImageURL.path stringByDeletingPathExtension];
        NSString *newPath = [originalPath stringByAppendingString:@".tiff"];
        return [NSURL fileURLWithPath:newPath];
    }
    
    return nil;
}

- (BOOL)isInputable {
    return ([self.type isEqualToString:(NSString *)kTISTypeKeyboardLayout] ||
            [self.type isEqualToString:(NSString *)kTISTypeKeyboardInputMode] ||
            [self.type isEqualToString:(NSString *)kTISTypeKeyboardInputMethodModeEnabled]);
}

@end
