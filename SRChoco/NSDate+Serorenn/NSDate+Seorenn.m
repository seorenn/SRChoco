//
//  NSDate+Seorenn.m
//
//  Created by Seorenn on 2014. 4. 4..
//  Copyright (c) 2014년 Seorenn. All rights reserved.
//

#import "NSDate+Seorenn.h"

#define DefaultISOFormat @"yyyy-MM-dd'T'HH:mm:ssZZZ"

@implementation NSDate (Seorenn)

- (NSCalendar *)UTCCalendar
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    calendar.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    return calendar;
}

#pragma mark - DateTime Components

- (NSInteger)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit fromDate:self];
    return [components year];
}
- (NSInteger)UTCYear
{
    NSCalendar *calendar = [self UTCCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit fromDate:self];
    return [components year];
}

- (NSInteger)month
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}
- (NSInteger)UTCMonth
{
    NSCalendar *calendar = [self UTCCalendar];
    NSDateComponents* components = [calendar components:NSMonthCalendarUnit fromDate:self];
    return [components month];
}

- (NSInteger)day
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSDayCalendarUnit fromDate:self];
    return [components day];
}
- (NSInteger)UTCDay
{
    NSCalendar* calendar = [self UTCCalendar];
    NSDateComponents* components = [calendar components:NSDayCalendarUnit fromDate:self];
    return [components day];
}

- (NSInteger)hour
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSHourCalendarUnit fromDate:self];
    return [components hour];
}
- (NSInteger)UTCHour
{
    NSCalendar* calendar = [self UTCCalendar];
    NSDateComponents* components = [calendar components:NSHourCalendarUnit fromDate:self];
    return [components hour];
}

- (NSInteger)minute
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSMinuteCalendarUnit fromDate:self];
    return [components minute];
}
- (NSInteger)UTCMinute
{
    NSCalendar* calendar = [self UTCCalendar];
    NSDateComponents* components = [calendar components:NSMinuteCalendarUnit fromDate:self];
    return [components minute];
}

- (NSInteger)second
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSSecondCalendarUnit fromDate:self];
    return [components second];
}
- (NSInteger)UTCSecond
{
    NSCalendar* calendar = [self UTCCalendar];
    NSDateComponents* components = [calendar components:NSSecondCalendarUnit fromDate:self];
    return [components second];
}

- (NSInteger)weekday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    return [components weekday];
}

- (NSInteger)countOfWeeks
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange weekRange = [calendar rangeOfUnit:NSWeekCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
    NSInteger weeksCount = weekRange.length;
    return weeksCount;
}

- (NSInteger)weekOfMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSWeekOfMonthCalendarUnit fromDate:self];
    return [components weekOfMonth];
}

#pragma mark - Utilities

- (BOOL)isAM
{
    if ([self hour] < 12) return YES;
    
    return NO;
}

- (BOOL)isPM
{
    return ![self isAM];
}

#pragma mark - NSDate with ISO Format

- (NSString *)ISOFormatString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [NSLocale currentLocale];
    [formatter setLocale:locale];
    [formatter setDateFormat:DefaultISOFormat];
    
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateFromISOFormatString:(NSString *)ISOFormatString
{
    NSRange r = [ISOFormatString rangeOfString:@"+"];
    if (r.location == NSNotFound) {
        ISOFormatString = [ISOFormatString stringByAppendingString:@"+0000"];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DefaultISOFormat];
    
    return [formatter dateFromString:ISOFormatString];
}

#pragma mark - Something Calucator (Need to working with UTC Time-zone)

- (NSDate *)firstDateOfCurrentWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self];
    
    NSDateComponents *componentsToSubtract  = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: (0 - [weekdayComponents weekday]) + 2];
    [componentsToSubtract setHour: 0 - [weekdayComponents hour]];
    [componentsToSubtract setMinute: 0 - [weekdayComponents minute]];
    [componentsToSubtract setSecond: 0 - [weekdayComponents second]];
    
    NSDate *beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    return beginningOfWeek;
}

- (NSDate *)lastDateOfCurrentWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *firstDate = [self firstDateOfCurrentWeek];
    
    NSDateComponents *componentsToAdd = [calendar components:NSDayCalendarUnit fromDate:firstDate];
    [componentsToAdd setDay:6];
    
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:firstDate options:0];
    
    return endOfWeek;
}

#pragma mark - NSDate Generator

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                    hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    
    NSDate *date = [calendar dateFromComponents:components];
    return date;
}

@end
