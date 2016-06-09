//
//  SYTextItem.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/8.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYTextItem.h"
#import "NSDate+SYExtension.h"
@implementation SYTextItem

-(NSString *)passtime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *create = [fmt dateFromString:_passtime];
    
    if (create.isThisYear) {
        if (create.isToday) {
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1)
            {
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else
            {
                return @"刚刚";
            }
        }else if (create.isYesterday){
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else
        {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else
    {
        return _passtime;
    }
    
    
    
    
}
@end
