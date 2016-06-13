//
//  SYCategoryItem.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/6/12.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYCategoryItem.h"
#import <MJExtension/MJExtension.h>
@implementation SYCategoryItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}
- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
