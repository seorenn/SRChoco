//
//  SRTISBridge.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 7. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

//#if TARGET_OS_MAC

#import <Foundation/Foundation.h>

@interface SRTISInfo : NSObject
@property (nonatomic, readonly) BOOL selectable;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *inputSourceID;
@property (nonatomic, readonly) NSURL *iconURL;
@end


@interface SRTISBridge : NSObject

@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) SRTISInfo *currentInputSource;

- (void)refresh;
- (SRTISInfo *)infoAtIndex:(NSInteger)index;
- (void)switchTISAtIndex:(NSInteger)index;

@end

//#endif  // TARGET_OS_MAC