//
//  SRTISBridge.h
//  SRChocoDemo-OSX
//
//  Created by Heeseung Seo on 2014. 7. 22..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRTISInfo : NSObject
@property (nonatomic, readonly) BOOL selectable;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *inputSourceID;
@property (nonatomic, readonly) NSURL *iconURL;
@end


@interface SRTISBridge : NSObject

@property (nonatomic, readonly) NSInteger count;

- (SRTISInfo *)infoAtIndex:(NSInteger)index;

@end
