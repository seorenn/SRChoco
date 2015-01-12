//
//  SRInputSourceManager.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2015. 1. 12..
//  Copyright (c) 2015년 Seorenn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRInputSource.h"

@interface SRInputSourceManager : NSObject

@property (nonatomic, readonly) NSArray *inputSources;
@property (nonatomic, readonly) SRInputSource *currentInputSource;
@property (nonatomic, readonly) NSInteger currentInputSourceIndex;

+ (SRInputSourceManager *)sharedManager;

- (void)refresh;
- (SRInputSource *)inputSourceWithInputSourceID:(NSString *)inputSourceID;

@end
