//
//  SYSettingItem.m
//  百思不得姐——框架完成
//
//  Created by 码农界四爷__King on 16/7/4.
//  Copyright © 2016年 码农界四爷__King. All rights reserved.
//

#import "SYSettingItem.h"

@implementation SYSettingItem
//实现类方法，进行赋值
+ (instancetype)itemWithTitle:(NSString *)title
{
    SYSettingItem *item = [[self alloc] init];
    
    item.title = title;
    
    return item;
}

@end
