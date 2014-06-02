//
//  NSDate+Seorenn.h
//
//  Created by Seorenn on 2014. 4. 4..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Seorenn)

#pragma mark - DateTime Components
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger UTCYear;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger UTCMonth;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger UTCDay;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger UTCHour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger UTCMinute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger UTCSecond;
@property (nonatomic, readonly) NSInteger weekday;   // sunday=1, monday=2, ...
@property (nonatomic, readonly) NSInteger countOfWeeks;
@property (nonatomic, readonly) NSInteger weekOfMonth;

#pragma mark - Utilities
@property (nonatomic, readonly) BOOL isAM;
@property (nonatomic, readonly) BOOL isPM;

#pragma mark - NSDate with ISO Format
- (NSString *)ISOFormatString;
+ (NSDate *)dateFromISOFormatString:(NSString *)ISOFormatString;

#pragma mark - Something Calucator (Need to working with UTC Time-zone)
- (NSDate *)firstDateOfCurrentWeek;
- (NSDate *)lastDateOfCurrentWeek;

#pragma mark - NSDate Generator
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                    hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

@end
