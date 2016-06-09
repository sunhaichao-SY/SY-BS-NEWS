//
//  NSDate+SYExtension.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/9.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "NSDate+SYExtension.h"

@implementation NSDate (SYExtension)

- (NSDateComponents *)deltaFrom:(NSDate *)from
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    return [calendar components:unit fromDate:from toDate:self options:NSCalendarWrapComponents];
}

- (BOOL)isThisYear
{

    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    return nowYear = selfYear;
    
}

- (BOOL)isToday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSString *selfString = [fmt stringFromDate:self];
    
    return [nowString isEqualToString:selfString];
}

- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *nowDate = [fmt dateFromString:[fmt stringFromDate:[NSDate date]]];
    NSDate *selDate = [fmt dateFromString:[fmt stringFromDate:self]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:selDate toDate:nowDate options:NSCalendarWrapComponents];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
@end













