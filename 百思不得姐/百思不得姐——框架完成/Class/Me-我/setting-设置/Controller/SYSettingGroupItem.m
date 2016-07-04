//
//  SYSettingGroupItem.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/4.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYSettingGroupItem.h"

@implementation SYSettingGroupItem

+ (instancetype)groupWithItems:(NSArray *)items
{
    SYSettingGroupItem *group = [[self alloc] init];
    
    group .items = items;
    
    return group;
}
@end
