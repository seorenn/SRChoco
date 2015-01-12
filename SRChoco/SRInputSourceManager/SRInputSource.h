//
//  SRInputSource.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 1. 12..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>

@interface SRInputSource : NSObject

@property (nonatomic, readonly) NSString *localizedName;
@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) NSString *type;
@property (nonatomic, readonly) BOOL isSelectCapable;
@property (nonatomic, readonly) NSURL *iconImageURL;
@property (nonatomic, readonly) NSURL *iconImageTIFFURL;
@property (nonatomic, readonly) NSImage *iconImage;

@property (nonatomic, readonly) BOOL isInputable;

- (id)initWithTISInputSourceRef:(TISInputSourceRef)tis;

- (void)activate;

@end
